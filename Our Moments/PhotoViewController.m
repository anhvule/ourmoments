//
//  PhotoViewController.m
//  Our Moments
//
//  Created by Vu Le on 6/5/15.
//  Copyright (c) 2015 Vu Le. All rights reserved.
//

#import "PhotoViewController.h"
//#import <BSImagePickerController/BSImagePickerController.h>
#import <BSImagePicker/BSImagePickerController.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CLImageEditor/CLImageEditor.h"

@interface PhotoViewController()
<CLImageEditorDelegate>
@end

@implementation PhotoViewController

- (void)presentImageEditorWithImage:(UIImage*)image
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [self presentViewController:editor animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *patternImage = [UIImage imageNamed:@"paper.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (UIImage *)imageFromAsset:(ALAsset *)asset
//{
//    UIImage *img = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage];
//    return img;
//}

- (IBAction)pickPhoto:(id)sender {
    BSImagePickerController *picker = [[BSImagePickerController alloc] init];
    [picker.view setTintColor:[UIColor redColor]];
    [picker.navigationBar setBarTintColor:[UIColor blackColor]];
    [picker.view setBackgroundColor:[UIColor blackColor]];
    [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    picker.delegate = self;

    [self presentImagePickerController:picker
                              animated:YES
                            completion:nil
                                toggle:^(ALAsset *asset, BOOL select) {
                                    if(select) {
                                        NSLog(@"Image selected");
                                    } else {
                                        NSLog(@"Image deselected");
                                    }
                                }
                                cancel:^(NSArray *assets) {
                                    NSLog(@"User canceled...!");
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                } finish:^(NSArray *assets) {
                                    NSLog(@"User finished :)!");
//                                    var image = [self imageFr]
//                                    [self presentImageEditorWithImage:]
                                    
                                    ALAsset *asset = (ALAsset*)assets[0];
                                    ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
                                    
//                                    UIImage *img = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage];
                                }];

}

#pragma mark- UIImageController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [picker pushViewController:editor animated:YES];
}

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    _imageView.image = image;
    [editor dismissViewControllerAnimated:YES completion:nil];
}
@end

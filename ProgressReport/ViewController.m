//
//  ViewController.m
//  ProgressReport
//
//  Created by xiang on 2017/3/22.
//  Copyright © 2017年 xiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (IBAction)go:(id)sender {
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    __block long totalComplete = 0;
    dispatch_source_set_event_handler(source, ^{
        long value = dispatch_source_get_data(source);
        totalComplete += value;
        self.progressView.progress = (CGFloat)totalComplete/100.0f;
    });
    dispatch_resume(source);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i <= 100; ++i) {
            dispatch_source_merge_data(source, 1);
            usleep(20000);
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.progressView.progress = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


















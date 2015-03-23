//
// This file is part of Akane
//
// Created by JC on 23/03/15.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

#import "AKNReusableViewHandler.h"

#import "AKNReusableView.h"
#import "AKNViewConfigurable.h"
#import "AKNViewModel.h"

@implementation AKNReusableViewHandler

- (void)reuseView:(id<AKNReusableView>)reusableView
    withViewModel:(id<AKNViewModel>)viewModel
      atIndexPath:(NSIndexPath *)indexPath {

    if (self.onReuse) {
        self.onReuse(reusableView, reusableView.itemView, indexPath);
    }

    reusableView.itemView.viewModel = viewModel;

    if ([viewModel respondsToSelector:@selector(willMount)]) {
        [viewModel willMount];
    }
}

@end

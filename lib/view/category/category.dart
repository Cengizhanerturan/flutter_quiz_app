import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Category extends BaseStatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Kategoriler'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          8.height,
          Expanded(
            child: StaggeredGridView.countBuilder(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 4,
              shrinkWrap: true,
              itemCount: _categoryController.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCard();
              },
              staggeredTileBuilder: (int index) {
                return StaggeredTile.count(2, index.isEven ? 2.2 : 1.8);
              },
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
            ).paddingSymmetric(horizontal: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return CustomInkWell(
      onTap: () {
        Get.toNamed(Routes.login);
      },
      child: ClayContainer(
        borderRadius: 16.0,
        color: theme.cardColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 20,
        spread: 1,
        curveType: CurveType.concave,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            16.height,
            _buildText(),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return ScaleFactorText(
      text: toCamelcase(text: category.categoryName),
      style: theme.textTheme.titleSmall!.medium,
    );
  }

  Widget _buildImage() {
    return ClayContainer(
      color: theme.scaffoldBackgroundColor,
      parentColor: theme.cardColor,
      borderRadius: 75,
      depth: 40,
      spread: 4,
      curveType: CurveType.concave,
      child: ImageIcon(
        NetworkImage(ApiConstants.baseURL + category.img),
        size: 32.0,
        color: theme.primaryColor,
      ).paddingAll(18.0),
    );
  }
}

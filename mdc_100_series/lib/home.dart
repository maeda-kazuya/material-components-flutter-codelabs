import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  // TODO: Make a collection of cards (102)
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        //brightness: Brightness.light,
        brightness: Brightness.dark,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('Menu button');
            },
        ),
        title: Text('SHRINE'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      body: AsymmetricView(products: ProductsRepository.loadProducts(Category.all)),
    );

//    return Scaffold(
//      // TODO: Add app bar (102)
//      appBar: AppBar(
//        leading: IconButton(
//          icon: Icon(
//            Icons.menu,
//            semanticLabel: 'menu',
//          ),
//          onPressed: () {
//            print('Menu button');
//          },
//        ),
//        title: Text('Shrine'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              semanticLabel: 'search',
//            ),
//            onPressed: () {
//              print('Search button');
//            },
//          ),
//          IconButton(
//            icon: Icon(
//              Icons.tune,
//              semanticLabel: 'filter',
//            ),
//            onPressed: () {
//              print('Filter button');
//            },
//          ),
//        ],
//      ),
//      // TODO: Add a grid view (102)
//      body: GridView.count(
//        crossAxisCount: 2,
//        padding: EdgeInsets.all(16),
//        childAspectRatio: 8/9,
//        children: _buildGridCards(context),
//      )
//    );
  }

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString()
    );

    return products.map((product) {
      return Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18/11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product == null ? '' : formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

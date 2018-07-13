const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const webpack = require('webpack');

const jquery = require('jquery');


module.exports = {
    resolve: {
        alias: {
            'node_modules': path.resolve(__dirname, 'node_modules'),
            'lib': path.resolve(__dirname, 'lib'),
            'jquery-ui': path.resolve(__dirname, 'node_modules/jquery-ui/ui/widgets'),
            'jquery-ui-css': path.resolve(__dirname, 'node_modules/jquery-ui/themes/base')
        }
    },
    output: {
        path: path.resolve(__dirname, './dist'),
        publicPath: '/',
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                use: [
                    'style-loader',
                    'css-loader'
                ],
            },
            {
                test: /\.s[a|c]ss$/,
                loader: 'style!css!sass'
            },
            {
                test: /\.js$/,
                loader: 'babel-loader',
                exclude: /node_modules/
            },
            {
                test: /\.(png|jpg|gif|svg|ttf|woff|woff2|eot)$/,
                loader: 'file-loader',
                options: {
                    name: '[name].[ext]?[hash]'
                }
            }
        ]
    },
    entry: [
        path.join(__dirname, 'lib', 'index.js'),
    ],
    devServer: {
        historyApiFallback: true,
        noInfo: true,
        overlay: true,
        contentBase: path.join(__dirname, "dist"),
        hot: true,
        open: true,
        watchContentBase: true,
        watchOptions: {
            poll: true
        }
    },
    mode: 'production',
    plugins: [
        new HtmlWebpackPlugin({
            title: 'My Great Appy'
        }),
        new webpack.ProvidePlugin({
            $: "jquery",
            jQuery: "jquery"
        })
    ]
}

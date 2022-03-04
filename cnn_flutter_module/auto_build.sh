#将Flutter生成的framework 输出到CNN-flutter-lib的私有库中。
ios_project_name='CNN-flutter-lib'    # 项目名称
ios_out_path='CNN-flutter-lib/ios_frameworks'    # 文件输出路径
flutter_git_path='https://github.com/MiaoPaSiFlutter/CNN-flutter-lib.git'    # git 项目路径
 
 
function customEcho(){
  echo "\033[1;32m$1\033[0m"
}
customEcho '\n1. 执行 flutter clean'
flutter clean || exit -1
 
 
customEcho '\n2. 清空build文件夹'
rm -rf $ios_project_name
rm -rf build
echo '清空完成'
 
 
customEcho '\n3. 生成 iOS frameworks'
flutter build ios --release --no-codesign || exit -1 
 
 
customEcho "\n4. 从 git 上克隆 frameworks 项目"
git clone $flutter_git_path  || exit -1 
 
 
customEcho "\n5. 输出文件到 $ios_out_path"
rm -rf $ios_out_path
mkdir $ios_out_path
 
 
 
 
cp -r build/ios/Release-iphoneos/*/*.framework $ios_out_path
cp -r build/ios/Release-iphoneos/*.framework $ios_out_path
# cp -r .ios/Flutter/App.framework $ios_out_path
# cp -r .ios/Flutter/engine/Flutter.framework $out
echo '输出完成'
 
 
customEcho "\n6. 提交文件到 git"
cd $ios_project_name
git add .
git commit -m 'update lib'
git push
 
customEcho "\n7. 进入该文件夹"
cd $ios_project_name/Example/
ls
pod install
# customEcho "\n7. 删除该文件夹"
# cd ..
# rm -rf $ios_project_name
 
 
customEcho "\nAll Done."
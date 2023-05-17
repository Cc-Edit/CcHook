#!/bin/bash
# 当前脚本执行环境是项目根目录，与其他项目引入路径不一样
source ../config.sh;

# 创建工作空间
rm -rf "workspace"
mkdir "workspace"
cd "workspace" || exit

# 下载新添加的赞赏用户信息
git clone git@github.com:Cc-Edit/Backers.git
B_EMAIL=$(cat Backers/email.txt)
B_LINK=$(cat Backers/link.txt)
B_NAME=$(cat Backers/name.txt)
B_HEAD_FILE="./Backers/head.png"
echo $B_EMAIL
echo $B_LINK
echo $B_NAME
echo $B_HEAD_FILE
# 发送邮件
B_EMAIL_TPL="
hi~ $B_NAME:
    感谢您的赞助，我们会将您的用户名以及头像添加到 GitHub 首页 Backers 模块中，以表达对您的感谢~
如果您希望定制您的信息，也可回复此邮件。（用户名、头像、外链地址可定制）
我用夸克网盘分享了「 webNote 」给你，点击链接即可保存。
文档持续补充升级，也可订阅下方链接，以便及时接收更新。
链接：https://**********   提取码：****
    再次提醒您，此文档仅限于个人学习使用，不可转发、转售或其他二次销售行为，不可将文档内容做二次分发发布
如遇下载失败或分享地址失败可直接回复此邮件，或加入微信群组@管理员。我们会最快速度回复您
                                                                        - 祝好 ^_^
";
B_EMAIL_TITLE="感谢赞助🥰『赠送您一份学习资料』"
echo "$B_EMAIL_TPL" | s-nail -s $B_EMAIL_TITLE $B_EMAIL;
echo  "已发送 $B_NAME - $B_EMAIL - $B_LINK" | s-nail -s "已发送：$B_EMAIL" ccedit@126.com
echo "email send success"

# 上传打赏用户头像
git clone git@github.com:Cc-Edit/static.git
B_STAMP=$(date +"%s")
B_STATIC_FILE="backers-$B_STAMP.png"
B_STATIC_PATH="./static/public/images/sponsor/$B_STATIC_FILE"
cp -fp $B_HEAD_FILE $B_STATIC_PATH
cd ./static || exit
git config user.email "ccedit@126.com"
git config user.name "ccedit"
git add .
git commit -m "add $B_NAME head image"
git push -f
cd ..
echo "static add success"

# 更新首页 Backers
git clone git@github.com:Cc-Edit/Cc-Edit.git
cd ./Cc-Edit || exit
B_BACKER_TAG="
  <a href='$B_LINK' title='$B_NAME' target='_blank' rel='noopener noreferrer'>
    <img alt='$B_NAME' src='https://static.sisjs.com/images/sponsor/$B_STATIC_FILE' width='30'>
  </a>
</p>"
B_BACKER_MD=$(cat ./BACKER.md)
B_INFO_MD=$(cat ./INFO.md)
B_BACKER_MD_NEW=${B_BACKER_MD/<\/p>/"$B_BACKER_TAG"}
B_README_MD_NEW="$B_INFO_MD
$B_BACKER_MD_NEW"
rm -rf ./BACKER.md
rm -rf ./README.md
echo "$B_BACKER_MD_NEW" >>./BACKER.md
echo "$B_README_MD_NEW" >>./README.md
git config user.email "ccedit@126.com"
git config user.name "ccedit"
git add .
git commit -m "add $B_NAME backer"
git push -f
cd ..
echo "homePage add backer success"

rm -rf "workspace"

echo "backers update success"

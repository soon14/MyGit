<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/style_script.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="feedback">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>新增环境图</title>
		<link rel="stylesheet" type="text/css" href="${staticURL}/css/feedback.css" />
	</head>
	<style>
		input[type='submit'],
		.mui-btn-my,
		.mui-btn-my {
			color: #fff;
			border: 1px solid #1799c5;
			background-color: #1799c5;
		}
		
		.mui-btn-my:enabled:active {
			color: #fff;
			border: 1px solid #1799c5;
			background-color: #1799c5;
		}
		
		.set-btn {
			height: 50px;
			width: 90%;
			font-size: 16px;
		}
		.layui-upload-file {
		    display: none!important;
		    opacity: .01;
		    filter: Alpha(opacity=1);
		}
		.mui-content-padded{
			margin:10px!important;
			padding:0px!important;
		}
	</style>

	<body>
		<header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">新增环境图</h1>
		</header>
		<div class="mui-content">
			<p>图片(选填,选择您想要的图片,总大小10M以下)</p>
			<div id='image-list' class="row image-list">
				<!--<div class="image-item" id="image-item-5" style="background-image: url(../../images/front/banner.gif);">
					<div class="image-close" id="img-5">X</div>
					<div class=""></div>
					<div class="file" id="image-5"></div>
				</div>-->
				<div class="image-item space" id="uploadImg">
					<div class="image-close">X</div>
					<div class="image-up"></div>
					<div class="file"></div>
				</div>
			</div>
			<div class="mui-button-row">
				<button type="button" class="mui-btn mui-btn-my set-btn" id="submit">发送</button>
			</div>
		</div>
		<script type="text/javascript">
		var pubEquipId = '${pubEquipId}';
			mui.init();
			layui.config({
				base: '${staticURL}/js/' //静态资源所在路径
			}).use('upload',function(){
				var $ = layui.jquery,
					upload = layui.upload;
				//上传封面预览
				var uploadInst = upload.render({
					elem: '#uploadImg',
					url: dynamicURL + '/mobile/venue/equipment/saveEnvironmentImg',
					headers: {sessionId: constants.getSettings().sessionId},
					data:{
						pubEquipId :pubEquipId
					},
					multiple: true, //是否多文件上传
					auto: false, //是否自动上传
					bindAction: '#submit',
					accept: 'images', //允许上传的文件类型
					number:9,//允许上文件数量
					choose: function(obj) {
						var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
						//预读本地文件示例，不支持ie8
						obj.preview(function(index, file, result) {
							var str=$(['<div id="image-item-'+index+'" class="image-item" style="background-image:url('+result+')"><div class="image-close">X</div></div>'].join(''));
							str.find(".image-close").on("click",function(){
								 delete files[index]; //删除对应的文件
								 str.remove();
								 uploadInst.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
							})
							$('#uploadImg').before(str);
						});
					},
					done: function(data,index) {
						if(data.success) {
							mui.alert("保存成功！",function () {
								mui.back();
							});
						} else {
							layer.alert(data.msg, {
								icon: 0
							});
						}
					},
					error: function(res) {
						mui.alert(res.msg);
					}
				});
			})
		</script>
	</body>

</html>
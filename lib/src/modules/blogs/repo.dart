import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ista_app/src/modules/blogs/logic.dart';
import 'package:ista_app/src/modules/blogs/model.dart';

blogRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BlogsLogic>().getAllBlogModel = GetAllBlogModel.fromJson(response);

    Get.find<BlogsLogic>().updateBlogLoader(true);

    if (Get.find<BlogsLogic>().getAllBlogModel.status == true) {
    } else {}
  } else if (!responseCheck) {
    Get.find<BlogsLogic>().updateBlogLoader(true);
  }
}
/**
 * Si responseCheck est true, la fonction analyse d'abord la réponse JSON à l'aide de la méthode GetAllBlogModel.fromJson() 
 * et définit l'objet résultant comme la valeur de la propriété getAllBlogModel de l'instance du singleton BlogsLogic obtenue via Get.find(). 
 * La fonction appelle ensuite updateBlogLoader(true) sur la même instance de BlogsLogic.
 * Si la propriété status de l'objet getAllBlogModel est true, la fonction ne fait rien. Sinon, il ne fait rien non plus.
 * Si responseCheck est false, la fonction appelle simplement updateBlogLoader(true) sur l'instance BlogsLogic obtenue via Get.find().
 * Dans l'ensemble, il semble que la fonction soit responsable de la mise à jour de l'état d'une instance BlogsLogic en fonction d'une réponse d'un appel API.
 */

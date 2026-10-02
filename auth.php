<?php
if(session_status()===PHP_SESSION_NONE) session_start();
function e($v){return htmlspecialchars((string)$v,ENT_QUOTES,'UTF-8');}
function login_required(){if(empty($_SESSION['user'])){header('Location: login.php');exit;}}
function role_required(array $roles){login_required();if(!in_array($_SESSION['user']['role'],$roles,true)){http_response_code(403);exit('<h2>Akses ditolak</h2><p>Role Anda tidak memiliki izin untuk halaman ini.</p>');}}
function flash($m=null){if($m!==null){$_SESSION['flash']=$m;return;} $x=$_SESSION['flash']??null;unset($_SESSION['flash']);return $x;}
?>
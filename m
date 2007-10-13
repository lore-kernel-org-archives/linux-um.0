Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgZ3N-0003U9-G4 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 21:56:45 -0700
Received: from bay0-omc2-s16.bay0.hotmail.com ([65.54.246.152])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgZ3N-0003R8-5g
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 21:56:45 -0700
Message-ID: <BLU102-W37724FC51969103D82EFACA9A10@phx.gbl>
From: Ahmad Sharif <ahmadsharif@hotmail.com>
Date: Sat, 13 Oct 2007 04:56:39 +0000
MIME-Version: 1.0
Subject: [uml-devel] accessing host resources from inside the UML kernel
Reply-To: madiyaan@fastmail.fm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1288695218=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1288695218==
Content-Type: multipart/alternative;
	boundary="_e0771fcc-2975-437a-ae80-2b18c9ff0a6b_"

--_e0771fcc-2975-437a-ae80-2b18c9ff0a6b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello:

I know this might be counter-intuitive and completely in the opposite direc=
tion of what people use UML for, but I have a question regarding accessing =
host's files from within UML (from the UML kernel, not user). Having said t=
hat, this is what I want:

I want to write a kernel module that I load from inside a running UML using=
 insmod that will be able to call functions like mmap(), ftok() etc. Here i=
s the important part: these functions should use the *host's* kernel, not t=
he UML's. This is because I want to do some IPC with another regular proces=
s that is running on the host. Here is the summary of what I want to do: th=
e host is running one regular process and UML, and from within the UML's ke=
rnel, I want to access the host's resources (like shared files and such).

If I compile a program from within UML and use the function mmap(), it will=
 link to mmap() implementation that is virtualized by UML. Instead, I want =
the real mmap() function (the host's mmap() function). Obviously because of=
 UML's design this shouldn't be possible from the user-space within UML... =
I am aware of that, which is why I said that my UML kernel module will have=
 this functionality of doing IPC with another process running on the host.

Is there an easy way of translating functions like mmap() and accessing the=
 host's files as a kernel module in UML? Maybe there are functions with nam=
es like host_mmap() or something like that, that can only be invoked from t=
he kernel of the UML?

If not, I was thinking of doing it this way: implement my own system call w=
rappers for each of the functions that I want like mmap(), ftok(), fopen(),=
 etc and compile UML. Then from inside the UML, I can call these functions =
and they will call the host's mmap(), ftok(), fopen(). First of all, will t=
his work? Secondly, a problem I foresee is that any process from inside the=
 UML can call these system calls (but I only want my own kernel module to b=
e able to do that... not any random user-level process).

If you have a better implementation that is easier/faster/effective, please=
 let me know. Goal is for a module in UML's kernel to be able to have acces=
s to host's functions and files like fopen(), etc. and do IPC with other pr=
ocesses running on the host.

Regards,

_________________________________________________________________
Boo!=A0Scare away worms, viruses and so much more! Try Windows Live OneCare=
!
http://onecare.live.com/standard/en-us/purchase/trial.aspx?s_cid=3Dwl_hotma=
ilnews=

--_e0771fcc-2975-437a-ae80-2b18c9ff0a6b_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">Hello:<br><br></=
div>I know this might be counter-intuitive and completely in the opposite d=
irection of what people use UML for, but I have a question regarding access=
ing host's files from within UML (from the UML kernel, not user). Having sa=
id that, this is what I want:<br><br>I want to write a kernel module that I=
 load from inside a running UML using insmod that will be able to call func=
tions like mmap(), ftok() etc. Here is the important part: these functions =
should use the *host's* kernel, not the UML's. This is because I want to do=
 some IPC with another regular process that is running on the host. Here is=
 the summary of what I want to do: the host is running one regular process =
and UML, and from within the UML's kernel, I want to access the host's reso=
urces (like shared files and such).<br><br>If I compile a program from with=
in UML and use the function mmap(), it will link to mmap() implementation t=
hat is virtualized by UML. Instead, I want the real mmap() function (the ho=
st's mmap() function). Obviously because of UML's design this shouldn't be =
possible from the user-space within UML... I am aware of that, which is why=
 I said that my UML kernel module will have this functionality of doing IPC=
 with another process running on the host.<br><br>Is there an easy way of t=
ranslating functions like mmap() and accessing the host's files as a kernel=
 module in UML? Maybe there are functions with names like host_mmap() or so=
mething like that, that can only be invoked from the kernel of the UML?<br>=
<br>If not, I was thinking of doing it this way: implement my own system ca=
ll wrappers for each of the functions that I want like mmap(), ftok(), fope=
n(), etc and compile UML. Then from inside the UML, I can call these functi=
ons and they will call the host's mmap(), ftok(), fopen(). First of all, wi=
ll this work? Secondly, a problem I foresee is that any process from inside=
 the UML can call these system calls (but I only want my own kernel module =
to be able to do that... not any random user-level process).<br><br>If you =
have a better implementation that is easier/faster/effective, please let me=
 know. Goal is for a module in UML's kernel to be able to have access to ho=
st's functions and files like fopen(), etc. and do IPC with other processes=
 running on the host.<br><br>Regards,<br><br /><hr />Boo!=A0Scare away worm=
s, viruses and so much more! Try Windows Live OneCare! <a href=3D'http://on=
ecare.live.com/standard/en-us/purchase/trial.aspx?s_cid=3Dwl_hotmailnews' t=
arget=3D'_new'>Try now!</a></body>
</html>=

--_e0771fcc-2975-437a-ae80-2b18c9ff0a6b_--


--===============1288695218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1288695218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1288695218==--


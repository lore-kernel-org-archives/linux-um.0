Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ENqMp-0001xT-3g	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 04:26:23 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ENqMo-0003wX-0Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Oct 2005 04:26:23 -0700
Received: by wproxy.gmail.com with SMTP id i4so328902wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Oct 2005 04:26:13 -0700 (PDT)
Message-ID: <229e70f20510070426j26f5a9e0s73185c9ae9ed86af@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] RPM problem in UML rootfs of FC4
In-Reply-To: <004f01c5cb31$43a68630$01fea8c0@lualele>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_46634_20097505.1128684373377"
References: <229e70f20510070245t6abdfe69s88a323bec24ba8be@mail.gmail.com>
	 <004f01c5cb31$43a68630$01fea8c0@lualele>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 7 Oct 2005 13:26:13 +0200
To: itamar <itamar@ispbrasil.com.br>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_46634_20097505.1128684373377
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/7/05, itamar <itamar@ispbrasil.com.br> wrote:
>
> first try this
>  rm -rf /var/lib/rpm/__*
> rpm --rebuilddb
>

EtayM: this one wasn't enough.

if don=B4t fix the problem try this
>     *echo "%__dbi_cdb create cdb private mpool mp_mmapsize=3D16Mb" >
> /etc/rpm/macros*
>

EtayM: this one worked.

rpm -qa
>  upgrade your FC4 using yum and remove the line *"%__dbi_cdb create cdb
> private mpool mp_mmapsize=3D16Mb" from /etc/rpm/macros*
>

EtayM: currently updating with yum...
Thanks a lot, Itamar.


--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_46634_20097505.1128684373377
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 10/7/05, <b class=3D"gmail_send=
ername">itamar</b> &lt;<a href=3D"mailto:itamar@ispbrasil.com.br">itamar@is=
pbrasil.com.br</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">







<div><font face=3D"Arial" size=3D"2">first try this</font></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2">rm -rf /var/lib/rpm/__*</font></div>
<div><font face=3D"Arial" size=3D"2">rpm --rebuilddb</font></div></blockquo=
te><div><br>
EtayM: this one wasn't enough. <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><f=
ont face=3D"Arial" size=3D"2">if don=B4t fix the problem try this</font></d=
iv>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><em>echo &quot;%__dbi_cdb&nbsp; create cdb private mpool mp_mmapsize=
=3D16Mb&quot; &gt;=20
/etc/rpm/macros</em></div></blockquote><div><br>
EtayM: this one worked. <br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><f=
ont face=3D"Arial" size=3D"2">rpm -qa</font></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2">upgrade your FC4 using yum and remove =
the line=20
<em><font face=3D"Times New Roman" size=3D"3">&quot;%__dbi_cdb&nbsp; create=
 cdb private=20
mpool mp_mmapsize=3D16Mb&quot; from /etc/rpm/macros</font></em></font></div=
></blockquote><div><br>
EtayM: currently updating with yum...<br>
Thanks a lot, Itamar.<br>
&nbsp;</div></div><br clear=3D"all"><br>-- <br>----------------------------=
--------------------------<br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gm=
ail.com">etay.meiri@gmail.com</a>

------=_Part_46634_20097505.1128684373377--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

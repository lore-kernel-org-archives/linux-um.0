Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPi9O-0004TS-8L	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 08:04:14 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EPi9K-00075p-PH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 08:04:11 -0700
Received: by wproxy.gmail.com with SMTP id i5so54683wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Oct 2005 08:03:47 -0700 (PDT)
Message-ID: <229e70f20510120803g7e00e0d2s81951984dfc63c6c@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] swap problem
In-Reply-To: <200510121649.54816.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8136_13153238.1129129427700"
References: <229e70f20510120701r3d5698ccy992263fac8a8082a@mail.gmail.com>
	 <200510121649.54816.blaisorblade@yahoo.it>
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
Date: Wed, 12 Oct 2005 17:03:47 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_8136_13153238.1129129427700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Great! it worked.

Thanks,

-Etay

On 10/12/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> Check the minor number. It should be 16, but there are around root_fs wit=
h
> number 1 (which was correct when UBD didn't support partitions). This
> would
> explain everything in your setup.
> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ
> 215621894)
> http://www.user-mode-linux.org/~blaisorblade
>
>
>
>
>
> ___________________________________
> Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
> http://mail.yahoo.it
>
>


--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_8136_13153238.1129129427700
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Great! it worked.<br>
<br>
Thanks,<br>
<br>
-Etay<br><br><div><span class=3D"gmail_quote">On 10/12/05, <b class=3D"gmai=
l_sendername">Blaisorblade</b> &lt;<a href=3D"mailto:blaisorblade@yahoo.it"=
>blaisorblade@yahoo.it</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
Check the minor number. It should be 16, but there are around root_fs with<=
br>number 1 (which was correct when UBD didn't support partitions). This wo=
uld<br>explain everything in your setup.<br>--<br>Inform me of my mistakes,=
 so I can keep imitating Homer Simpson's &quot;Doh!&quot;.
<br>Paolo Giarrusso, aka Blaisorblade (Skype ID &quot;PaoloGiarrusso&quot;,=
 ICQ 215621894)<br><a href=3D"http://www.user-mode-linux.org/~blaisorblade"=
>http://www.user-mode-linux.org/~blaisorblade</a><br><br><br><br><br><br>
___________________________________<br>Yahoo! Mail: gratis 1GB per i messag=
gi e allegati da 10MB<br><a href=3D"http://mail.yahoo.it">http://mail.yahoo=
.it</a><br><br></blockquote></div><br><br clear=3D"all"><br>-- <br>--------=
----------------------------------------------
<br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.=
com</a>

------=_Part_8136_13153238.1129129427700--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

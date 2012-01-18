Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <allskyee@gmail.com>) id 1RnWXg-0007bN-Dz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2012 14:31:12 +0000
Received: from mail-qw0-f54.google.com ([209.85.216.54])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RnWXb-0007xW-6S
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2012 14:31:12 +0000
Received: by qaea17 with SMTP id a17so1078160qae.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Jan 2012 06:31:01 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 18 Jan 2012 23:31:01 +0900
Message-ID: <CADW8t6xtpMEYrVFvMkT7HMJMeiQoOGzT8LHYG48YMApe3efgJA@mail.gmail.com>
From: =?UTF-8?B?7KCE7ZWY64qY?= <allskyee@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9101126852095044460=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] BUGFIX : insmod fail with message "overflow in
 relocation type 11..." for mem=504M and above
To: user-mode-linux-devel@lists.sourceforge.net

--===============9101126852095044460==
Content-Type: multipart/alternative; boundary=20cf3005ddc4055ea004b6ce4c5b

--20cf3005ddc4055ea004b6ce4c5b
Content-Type: text/plain; charset=ISO-8859-1

I found the problem while transitioning to a 64bit machine

The problem seems to exist for physical memory *exceeding
504MB*because that is the precise limit which tips
*VMALLOC_START *with MSB being 1

That would be a problem for 64bit machines since in symbol relocation
function, namely *apply_relocate_add *in arch/x86/kernel/module.c:249,
evaluating *R_X86_64_32S *sign extends 64bit values

The root of the problem though, is that  *VMALLOC_START * start is too big
to begin with since *START *is too big in *Makefile-x86_64 *
*
*
Changing to a smaller value, like say 0x8048000 used for i386 machines
seems to do the trick

Any reason it was 0x60000000 ??

--20cf3005ddc4055ea004b6ce4c5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I found the problem while transitioning to a 64bit machine<div><div><br><di=
v>The problem seems to exist for physical memory <b>exceeding 504MB</b> bec=
ause=A0that is the precise limit which tips <b>VMALLOC_START </b>with MSB b=
eing 1</div>
</div></div><div><br></div><div>That would be a problem for 64bit machines =
since in=A0symbol relocation function, namely <b>apply_relocate_add </b>in=
=A0arch/x86/kernel/module.c:249,</div><div>evaluating <b>R_X86_64_32S=A0</b=
>sign extends 64bit values</div>
<div><br></div><div>The root of the problem though, is that=A0
<b>VMALLOC_START=A0</b>=A0start is too big to begin with since <b>START </b=
>is too big in=A0<b><u><i>Makefile-x86_64=A0</i></u></b></div><div><b><u><i=
><br></i></u></b></div><div>Changing to a smaller value, like say=A00x80480=
00 used for i386 machines seems to do the trick</div>
<div><br></div><div>Any reason it was=A00x60000000 ??</div>

--20cf3005ddc4055ea004b6ce4c5b--


--===============9101126852095044460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--===============9101126852095044460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============9101126852095044460==--



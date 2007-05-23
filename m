Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HqyzF-0004Hw-6r for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 15:07:23 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Hqyz9-00022u-UT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 15:07:16 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 24 May 2007 00:06:48 +0200
References: <dec0fd580705230534ga1614a8y464bd23be785cabe@mail.gmail.com>
In-Reply-To: <dec0fd580705230534ga1614a8y464bd23be785cabe@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705240006.48889.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] Doubt regarding UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-user@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net, battipatisainagendra Bhavaniprasad <sainagendrabhavaniprasad@gmail.com>

On mercoled=EC 23 maggio 2007, battipatisainagendra Bhavaniprasad wrote:
> Hi All,
>            This is prasad,I am new to UML.Can any one clearfy the
>  following doubts....
> 1.What is skas patch,is it required for 2.6 kernel or i comes with
>  built in and if apply skas patch for my host kernel ,is it required to
>  recompile the hole kernel and then install UML.

No vanilla kernel (nor 2.4 nor 2.6) contains already the SKAS3 patch.
But recent UML kernel can run on any host in SKAS0 mode, slightly slower bu=
t=20
good for normal use.
Otherwise, you can recompile the host kernel after applying on it the SKAS =

patch and UML kernels will automatically use the faster SKAS3 mode.

> 2.I have downloaded linux 2.4.27 from kernel.org and applyed
> uml-patch-2.4.27-1.bz2 to it.
>   after giving following command ......
>   make menuconfig ARCH=3Dum
>   I have got a prompt to select SKAS mode in gendral setup option.

>  My doubt is will linux 2.4.20(which is my host kernel) will have
> already skas patch built in?

No vanilla kernel (nor 2.4 nor 2.6) contains already the SKAS3 patch.

> 3.Is there any document to debug kernel by mounting gdb from host kernel.
There are. Go to this page:
http://user-mode-linux.sourceforge.net/
and look for "debugging" in _that_ page. Then follow the "debugging in SKAS=
=20
mode".
--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


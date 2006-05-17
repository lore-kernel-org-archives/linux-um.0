Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgOg3-0006gU-B6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 09:15:11 -0700
Received: from terminus.zytor.com ([192.83.249.54] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FgOg1-0007Ve-Ap
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 09:15:11 -0700
Message-ID: <446B4BF9.4000800@zytor.com>
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <E1FgNkr-00024G-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1FgNkr-00024G-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: klibc build broken on UML
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
Date: Wed, 17 May 2006 09:14:49 -0700
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org

Miklos Szeredi wrote:
> [resent because prev. post bounced on hpa and akpm due to mail problems here]
> 
> I get this on 2.6.17-rc4-mm1:
> 
>   CHK     include/linux/compile.h
> /usr/src/quilt/linux/scripts/Kbuild.klibc:60: /usr/src/quilt/linux/usr/klibc/arch/um/MCONFIG: No such file or directory
> usr/klibc/Kbuild:71: usr/klibc/arch/um/Makefile.inc: No such file or directory
> make[2]: *** No rule to make target `usr/klibc/arch/um/Makefile.inc'.  Stop.
> make[1]: *** [_usr_klibc] Error 2
> make: *** [usr] Error 2
> 
> Miklos

Known and fixed in my git tree already.

	-hpa


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

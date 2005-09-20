Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <29D15BBCA340DA4D8146D38B4924FC7A023B483B@zcarhxm0.corp.nortel.com>
From: "Majid Salame" <msalame@nortel.com>
Subject: [uml-devel] Skas_ptrace.h error
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
Date: Tue, 20 Sep 2005 14:56:30 -0400
Content-Transfer-Encoding: 8bit
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net


I received the following error when compiling UML for kernel 2.6.10. I
am unable to trace the redefinition. Has anyone seen this error?


arch/um/include/skas_ptrace.h:10: error: redefinition of `struct
ptrace_faultinfo'
arch/um/include/skas_ptrace.h:15: error: redefinition of `struct
ptrace_ldt'
make[1]: *** [arch/um/util/mk_constants_kern.o] Error 1

Thanks,
MS.




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

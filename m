Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1QB787-000136-1V
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2011 15:09:47 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QB786-0004Aj-Dy
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2011 15:09:47 +0000
Received: by iwn10 with SMTP id 10so4027976iwn.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 16 Apr 2011 08:09:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201104161604.18054.walch.martin@web.de>
References: <201104161604.18054.walch.martin@web.de>
Date: Sat, 16 Apr 2011 17:09:41 +0200
Message-ID: <BANLkTik1dT1zhp4peK=W5e0UC-CB0V1Jdw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=002215048b9738242804a10a8c99
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Linux Kernel Bug #32812 "ARCH=um,
 SUBARCH=i386: linking failure"
To: Martin Walch <walch.martin@web.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

--002215048b9738242804a10a8c99
Content-Type: text/plain; charset=ISO-8859-1

Hi Martin,

On Sat, Apr 16, 2011 at 4:04 PM, Martin Walch <walch.martin@web.de> wrote:
> Hello UML maintainers,
>
> I have run into a problem making a uml kernel for SUBARCH=i386 with support
> for XFS. This looks like a regression. Can you please take a look at
>
> https://bugzilla.kernel.org/show_bug.cgi?id=32812

The cmpxchg8b_emu issue is already known and fixed.
See:
http://git.kernel.org/linus/084189a

For the atomic64_read_386 issue I've attached a patch.
WARING: It's only compile time tested. :)

Please apply both and retry.

Thanks,
//richard

> Thank you.
>
> Martin Walch
> --
>
> ------------------------------------------------------------------------------
> Benefiting from Server Virtualization: Beyond Initial Workload
> Consolidation -- Increasing the use of server virtualization is a top
> priority.Virtualization can reduce costs, simplify management, and improve
> application availability and disaster protection. Learn more about boosting
> the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-- 
Thanks,
//richard

--002215048b9738242804a10a8c99
Content-Type: text/x-patch; charset=US-ASCII;
	name="disable_X86_CMPXCHG64.patch"
Content-Disposition: attachment; filename="disable_X86_CMPXCHG64.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmkonivn0

ZGlmZiAtLWdpdCBhL2FyY2gvdW0vS2NvbmZpZy54ODYgYi9hcmNoL3VtL0tjb25maWcueDg2Cmlu
ZGV4IGE5ZGE1MTYuLjIyOWM2ZjAgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vS2NvbmZpZy54ODYKKysr
IGIvYXJjaC91bS9LY29uZmlnLng4NgpAQCAtOCw2ICs4LDEwIEBAIGNvbmZpZyBDTVBYQ0hHX0xP
Q0FMCiAJYm9vbAogCWRlZmF1bHQgbgogCitjb25maWcgWDg2X0NNUFhDSEc2NAorCWJvb2wKKwlk
ZWZhdWx0IG4KKwogc291cmNlICJhcmNoL3g4Ni9LY29uZmlnLmNwdSIKIAogZW5kbWVudQo=
--002215048b9738242804a10a8c99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
--002215048b9738242804a10a8c99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--002215048b9738242804a10a8c99--



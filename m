Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UOxYg-0000OY-2z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 21:55:30 +0000
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UOxYd-0006Kp-SS
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Apr 2013 21:55:29 +0000
Received: by mail-wi0-f178.google.com with SMTP id ez12so2016416wid.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 07 Apr 2013 14:55:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51879.173.206.136.128.1365359421.squirrel@webmail3.pt.com>
References: <CAER6CkdnaFQshNMPkQVdXjB9Z3MyoMTg+grcPwwW=yGVjmhEZg@mail.gmail.com>
	<CAFLxGvy7gWtSk4fNq+UnpX0_g6sYHgPo6nft9ghJR4ktvWmAPQ@mail.gmail.com>
	<51879.173.206.136.128.1365359421.squirrel@webmail3.pt.com>
Date: Sun, 7 Apr 2013 23:55:21 +0200
Message-ID: <CAFLxGvywzy=F=rxK3s2BThSNDgK0Pzr0BE_Qie5YN3mqOH6eVA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=089e0102ee0675d14004d9cc6050
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
Subject: Re: [uml-devel] Endless page fault for the same miss address in my
	UML
To: Peter Butler <pbutler@pt.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--089e0102ee0675d14004d9cc6050
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Apr 7, 2013 at 8:30 PM, Peter Butler <pbutler@pt.com> wrote:
> Here's one more example, still the same setup, but this time crashing at
> the same place as the original bug report. (BUG: failure at
> block/blk-core.c:2978/blk_flush_plug_list()!) See below for output.
>
> BTW my host setup is Linux Mint 14:
>
> Linux ufo 3.5.0-17-generic #28-Ubuntu SMP Tue Oct 9 19:31:23 UTC 2012
> x86_64 x86_64 x86_64 GNU/Linux
>
>
>
> bash $ ./linux ubd0=Fedora18-AMD64-root_fs rw mem=4096M con0=fd:0,fd:1

Please don't post into unrelated threads.

Anyway, all your crashes share one thing, before the crash UML did a
sigsuspend().
It does only so in the SIGWINCH irq path.

To verify ma theory please apply the attached patch. It disables the
feature that you can resize an UML
window on the host side and UML will change the terminal size in the guest.

Thanks,
//richard

--089e0102ee0675d14004d9cc6050
Content-Type: application/octet-stream; name="no_winch.diff"
Content-Disposition: attachment; filename="no_winch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hf8r2emh0

ZGlmZiAtLWdpdCBhL2FyY2gvdW0va2VybmVsL3RyYXAuYyBiL2FyY2gvdW0va2VybmVsL3RyYXAu
YwppbmRleCAwODlmMzk4Li5lNGJkZDZkIDEwMDY0NAotLS0gYS9hcmNoL3VtL2tlcm5lbC90cmFw
LmMKKysrIGIvYXJjaC91bS9rZXJuZWwvdHJhcC5jCkBAIC0zMDgsNyArMzA4LDcgQEAgdm9pZCBi
dXNfaGFuZGxlcihpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5mbyAqc2ksIHN0cnVjdCB1bWxfcHRfcmVn
cyAqcmVncykKIAogdm9pZCB3aW5jaChpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5mbyAqdW51c2VkX3Np
LCBzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnJlZ3MpCiB7Ci0JZG9fSVJRKFdJTkNIX0lSUSwgcmVncyk7
CisJLy9kb19JUlEoV0lOQ0hfSVJRLCByZWdzKTsKIH0KIAogdm9pZCB0cmFwX2luaXQodm9pZCkK
--089e0102ee0675d14004d9cc6050
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
--089e0102ee0675d14004d9cc6050
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--089e0102ee0675d14004d9cc6050--



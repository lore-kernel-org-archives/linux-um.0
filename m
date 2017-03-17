Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1covGh-0007Iu-Kz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:02:23 +0000
Received: from mail-ot0-f195.google.com ([74.125.82.195])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1covGf-0007qH-SQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 17:02:23 +0000
Received: by mail-ot0-f195.google.com with SMTP id a12so13530625ota.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 10:02:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170215143153.4h3uwrkpt4odkavr@judith.localdomain>
References: <20170215143153.4h3uwrkpt4odkavr@judith.localdomain>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 17 Mar 2017 18:02:16 +0100
Message-ID: <CAFLxGvxgkGrj=S-9tRfqwJVpnGH6Zj7hczgU4PUBR2o7+XA5Ew@mail.gmail.com>
Subject: Re: [uml-devel] FPU patches broke UML on i7-7700 CPU
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Natale Patriciello <natale.patriciello@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Natale,

On Wed, Feb 15, 2017 at 3:31 PM, Natale Patriciello
<natale.patriciello@gmail.com> wrote:
>
> Hello,
>
> as I've reported here [1], by changing the work station I've got the
> same UML guest not working anymore. I investigated and the problem root
> is in the code added in this patchset [2] (add extended processor state
> save/restore support). In particular, the ptrace returns < 0 and the
> errno is set to 14. Reverting the code to use the functions
> *_i387_registers () makes everything to work correctly.
>
> There is something I can do for further debugging the issue? Or should I
> live with a modified kernel tree with a reverse patch applied ?

When reporting such bugs, please always CC all affected parties.
Especially the author of the offending patch.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


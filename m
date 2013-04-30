Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UX3Oc-00035S-6H
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Apr 2013 05:46:34 +0000
Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UX3Ob-0000Qi-Fy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Apr 2013 05:46:34 +0000
Received: by mail-wg0-f43.google.com with SMTP id c11so101117wgh.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 Apr 2013 22:46:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+ve00TPpqBUPmEZhfpDQ9G58NT0paXRvZZhrJM-vm6Z5egoaw@mail.gmail.com>
References: <CA+ve00TPpqBUPmEZhfpDQ9G58NT0paXRvZZhrJM-vm6Z5egoaw@mail.gmail.com>
Date: Tue, 30 Apr 2013 07:46:27 +0200
Message-ID: <CAFLxGvx_o-ki=D6N+h646pBeR6G2cZ+27ok3i2NTEj8N7kWj+g@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] SKAS mode and UML code
To: Earlence Fernandes <earlenceferns@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Apr 30, 2013 at 1:23 AM, Earlence Fernandes
<earlenceferns@gmail.com> wrote:
> From the book by Jeff Dike, I get the impression that the UML kernel is
> placed in a reserved memory section in every process it virtualizes. Is this
> a correct interpretation?

Better read the book twice. ;)
That is exactly what SKAS mode solves.
TT mode suffered from that.

--
Thanks,
//richard

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


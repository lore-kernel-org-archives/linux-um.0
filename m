Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1c71Jq-000199-Ky
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 14:36:10 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c71Jp-0007b4-AC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 14:36:10 +0000
References: <20161110015326.GA51351@juliacomputing.com>
	<81f0fb21-e336-ed4c-4346-5f54836f5d8c@nod.at>
	<CABV8kRyfAWTMPoaTid2vDvOUWajegvsiYzwcUTe0_J1H-s9JVQ@mail.gmail.com>
	<5718c625-bf94-dbd7-c7f5-14957d6b04d9@nod.at>
	<CABV8kRwdoL6tdneEWBLQcMsKpdG4nAAP+R98O7pBUKJ+-HdWJg@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <384fd301-0a12-74e8-8ccd-114f61acbfe4@nod.at>
Date: Wed, 16 Nov 2016 15:36:00 +0100
MIME-Version: 1.0
In-Reply-To: <CABV8kRwdoL6tdneEWBLQcMsKpdG4nAAP+R98O7pBUKJ+-HdWJg@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Fix compile failure due to
 current_text_address() definition
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
To: Keno Fischer <keno@juliacomputing.com>
Cc: jdike@addtoit.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Keno,

On 16.11.2016 04:45, Keno Fischer wrote:
> Just as an FYI, the linker bug has been fixed in binutils.

Interesting. Is the same bug also the root cause why a static build
of UML does not work?

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


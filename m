Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QlLhh-00012O-B6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jul 2011 14:00:17 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QlLhc-0000sb-Ms
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jul 2011 14:00:17 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 25 Jul 2011 16:00:03 +0200
References: <1311438111-10961-1-git-send-email-cascardo@holoscopio.com>
In-Reply-To: <1311438111-10961-1-git-send-email-cascardo@holoscopio.com>
MIME-Version: 1.0
Message-Id: <201107251600.03311.richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH] um: disable CMPXCHG_DOUBLE as it breaks UML
	build
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: jdike@addtoit.com, Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Am Samstag 23 Juli 2011, 18:21:51 schrieb Thadeu Lima de Souza Cascardo:
> Commit b789ef518b2a7231b0668c813f677cee528a9d3f tests for cmpxchg_double
> support in the SLUB code and it breaks UML builds with SLUB. Since UML
> does not support checking for CPU features, disable CMPXCHG_DOUBLE just
> like CMPXCHG_LOCAL is disabled for UML.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>

Applied!

Thanks,
//richard

------------------------------------------------------------------------------
Storage Efficiency Calculator
This modeling tool is based on patent-pending intellectual property that
has been used successfully in hundreds of IBM storage optimization engage-
ments, worldwide.  Store less, Store more with what you own, Move data to 
the right place. Try It Now! http://www.accelacomm.com/jaw/sfnl/114/51427378/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


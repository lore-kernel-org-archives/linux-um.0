Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <greg@kroah.com>) id 1QCYMH-0005YX-JH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Apr 2011 14:26:21 +0000
Received: from kroah.org ([198.145.64.141] helo=coco.kroah.org)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QCYMF-0001tH-Bj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Apr 2011 14:26:21 +0000
Date: Wed, 20 Apr 2011 07:27:02 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20110420142702.GB22114@kroah.com>
References: <1303299266-10219-1-git-send-email-richard@nod.at>
	<1303299266-10219-2-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1303299266-10219-2-git-send-email-richard@nod.at>
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
Subject: Re: [uml-devel] [stable] [PATCH 2/3] um: Add support for 64 bit
	atomic operations
To: Richard Weinberger <richard@nod.at>
Cc: stable@kernel.org, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Apr 20, 2011 at 01:34:25PM +0200, Richard Weinberger wrote:
> This adds support for 64 bit atomic operations on
> 32 bit UML systems.
> XFS needs them since 2.6.38.
> 
> Reported-by: Martin Walch <walch.martin@web.de>
> Tested-by: Martin Walch <walch.martin@web.de>
> Cc: Martin Walch <walch.martin@web.de>
> Cc: <stable@kernel.org> # .38.x 084189a: um: disable CONFIG_CMPXCHG_LOCAL

Why is this a stable patch?

confused,

greg k-h

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


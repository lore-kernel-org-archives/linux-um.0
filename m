Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcUo9-0003Xx-87 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 13:27:09 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcUo8-0005pk-09
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 13:27:09 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.11.2) with ESMTP id jAGKIAm05412
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Nov 2005 15:18:11 -0500
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.13.4/8.13.4) with ESMTP id
	jAGMJouj010448 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Nov 2005 17:19:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
Message-ID: <20051116221948.GA10366@ccure.user-mode-linux.org>
References: <200511161100.31053.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511161100.31053.rob@landley.net>
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
Date: Wed, 16 Nov 2005 17:19:48 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 16, 2005 at 11:00:30AM -0600, Rob Landley wrote:
> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for 
> SIGUSR1/SIGTRAP, pid = 13213, n = 13213, errno = 0, status = 0xb7f

Can you try my latest patchset?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

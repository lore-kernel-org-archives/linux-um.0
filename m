Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVZ85-0008Dl-ND	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 11:06:49 -0700
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]
	helo=g5.random)	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DVZ83-0004ik-U7	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 11:06:49 -0700
From: Andrea Arcangeli <andrea@suse.de>
Message-ID: <20050510180642.GY6313@g5.random>
References: <20050509224509.0C105416E4@zion>
	<20050509183401.28082cbc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509183401.28082cbc.akpm@osdl.org>
Subject: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix, for
	2.6.12 ]
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
Date: Tue, 10 May 2005 20:06:42 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, May 09, 2005 at 06:34:01PM -0700, Andrew Morton wrote:
> I'll just ask Linus to delete it ;)

make distclean should delete it too. I never worry about zero length
file, they'll be deleted eventually.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

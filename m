Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiOQp-0008Tp-3d for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 19:14:39 -0700
Received: from mproxy.gmail.com ([216.239.56.248])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BiOQo-0006M9-S5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 19:14:39 -0700
Received: by mproxy.gmail.com with SMTP id r62so392145cwc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 07 Jul 2004 19:14:29 -0700 (PDT)
Message-ID: <16f5f6240407071914138341e3@mail.gmail.com>
From: Eddy Yuniar <dogmaphobia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] problem with hostfs in statfs... (2.6.7)
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
Date: Thu, 8 Jul 2004 09:14:29 +0700
To: user-mode-linux-devel@lists.sourceforge.net

I''ve runnning a problem when invoking df from the shell.... and got
kernel panic...
the problem is in hostfs_statfs when calling do_statfs, parameter
sf->f_spare should be substituted with sf->f_frsize, because there is
a change in struct kstatfs with addition f_frsize that using one of
f_spare array.... so array f_spare now only have size 5....


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

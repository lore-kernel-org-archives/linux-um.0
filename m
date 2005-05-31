Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdB3i-0005oz-IZ	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 11:01:46 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DdB3g-0005Q6-7r	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 11:01:46 -0700
Message-Id: <s29c447f.050@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Subject: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1
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
Date: Tue, 31 May 2005 11:03:23 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

I'm running into a problem applying the latest tarball from Jeff's tree. I've downloaded the linux-2.6.12-rc5 source and applied the -mm1 patches with:

# bzip2 -dc ../2.6.12-rc5-mm1.bz2 |patch -p1

This applied without issue. I then tried to apply the tarball from Jeff's patches:

# quilt push -a
Applying patch set-tsk-need-resched
patching file arch/um/kernel/process_kern.c

< output trimmed >

Applying patch os-main
patching file arch/um/kernel/Makefile
patching file arch/um/kernel/main.c
Hunk #1 FAILED at 1.
File arch/um/kernel/main.c is not empty after patch, as expected
1 out of 1 hunk FAILED -- rejects in file arch/um/kernel/main.c
patching file arch/um/kernel/um_arch.c
patching file arch/um/os-Linux/Makefile
patching file arch/um/os-Linux/main.c
Patch os-main does not apply (enforce with -f)
# 

Any ideas?

Tony



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

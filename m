Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgSIg-0001Qn-8b for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 09:25:58 -0800
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AgSIf-0001XV-O2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 09:25:57 -0800
From: Michael Koehne <kraehe@copyleft.de>
Subject: Re: [uml-devel] UML and AMD-64
Message-ID: <20040113172553.GA28699@bakunin.copyleft.de>
References: <200401131451.i0DEp8hg001684@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401131451.i0DEp8hg001684@ccure.user-mode-linux.org>
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
Date: Tue, 13 Jan 2004 18:25:53 +0100
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Moin Jeff Dike,

> > Is there any possibility of running a 64-bit UML virtual machine on an
> > AMD-64 ? 
> It is, and I'm working on it.

  i'm thinking about upgrading my oldest UML system to either a
  BiAthlon, which is known to work with SKAS, or to wait a few
  month more a dual Opteron system to become cheap. I remember
  the TT problems of UML running on duals, leading me to install
  SKAS.  Are there any experiences about running UML on an 64bit
  NUMA system ?

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

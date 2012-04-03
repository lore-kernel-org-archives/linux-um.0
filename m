Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SFAV8-0004LR-2W for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2012 20:38:50 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SFAV5-0007l8-DO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2012 20:38:50 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SFAUx-0005r4-6E for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2012 22:38:39 +0200
Received: from 122.167.229.251 ([122.167.229.251])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:38:39 +0200
Received: from rrs by 122.167.229.251 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:38:39 +0200
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Wed, 04 Apr 2012 01:17:40 +0530
Message-ID: <4F7B53DC.1040602@debian.org>
References: <E1SEjI8-0007kU-RE@franck.debian.org> <4F7AFA9E.5020306@debian.org>
	<CAFLxGvwSVTnoaky43CvUHs8gKT5m5w81YcUw6DC_PTeN2DF+AA@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <CAFLxGvwSVTnoaky43CvUHs8gKT5m5w81YcUw6DC_PTeN2DF+AA@mail.gmail.com>
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
Subject: Re: [uml-devel] UML static linking and embedded library
To: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 03 April 2012 10:35 PM, richard -rw- weinberger wrote:
> Solving the first issue is straight forward.
> For the second one I've to think a bit why Jeff took the current
> static linking approach.
> 
> Expect patches for both issues in 3.5. :-)

Thanks. Can you prepare the patch?

We are going to ship Debian 7 (Wheezy) with kernel v3.2. Based on what
you prepare, I will backport it.

Thanks,
Ritesh

-- 
Given the large number of mailing lists I follow, I request you to CC me
in replies for quicker response


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


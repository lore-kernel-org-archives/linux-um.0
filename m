Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DZ4lK-0005uV-C3	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 May 2005 03:29:50 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DZ4lG-0000mx-MH	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 May 2005 03:29:50 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] applying a .diff.bz2 patch
In-Reply-To: <838f7c500505191230655a04a0@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0505201227450.17086@filer.marasystems.com>
References: <838f7c500505191230655a04a0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Fri, 20 May 2005 12:29:26 +0200 (CEST)
To: ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 19 May 2005, ashwin tanugula wrote:

> Hi
> How do i apply a .diff.bz2 patch to a linux kernel?

Usually by

cd linux-x.y.z
bzcat /path/to/patchfile.diff.bz2 | patch -p1 -s

then rebuild the kernel.


Sometimes -p0 is required instead of -p1, but very rarely (depends on who 
made the patch and how, see "man patch" for details)

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

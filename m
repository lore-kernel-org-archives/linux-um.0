Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfbjQ-0001LG-SF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 03:27:08 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EfbjQ-0007sb-CK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Nov 2005 03:27:08 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511250348.28123.rob@landley.net>
	<200511250452.05006.rob@landley.net>
In-Reply-To: <200511250452.05006.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511250526.56755.rob@landley.net>
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
Date: Fri, 25 Nov 2005 05:26:55 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Friday 25 November 2005 04:52, Rob Landley wrote:
> FYI:
>
> The mounts on a Fedora Core 4 system:
...
> The mounts on the x86-64 PLD system I've been borrowing (and on which I do
> not have root access):
...
> The shell servers from sourceforge:
...
> And I reiterate that on my ubuntu laptop /tmp is not tmpfs (it inherits my
> ext3 /) but /dev/shm is a world writeable tmpfs mount that has the sticky
> bit set.
...

Found one more lying around:  A gentoo system my friend mark set up.  Can't 
easily cut and paste the mount table from here (it's a laptop), but /tmp 
inherits / which is ext3, and /dev/shm is a tmpfs mount which is world 
writeable and has the sticky bit set.

Except for the x86-64 PLD system (which is already known to be weird), it's 
unanimous so far...

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

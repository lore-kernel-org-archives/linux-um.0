Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9BQ9-0002TW-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 13 Oct 2003 15:44:09 -0700
Received: from fed1mtao02.cox.net ([68.6.19.243])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9BQ8-0000GH-ET
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 13 Oct 2003 15:44:08 -0700
Received: from easyco.com ([68.109.90.156]) by fed1mtao02.cox.net
          (InterMail vM.5.01.06.05 201-253-122-130-105-20030824) with ESMTP
          id <20031013224336.GAVN27579.fed1mtao02.cox.net@easyco.com>
          for <user-mode-linux-devel@lists.sourceforge.net>;
          Mon, 13 Oct 2003 18:43:36 -0400
Message-ID: <3F8B2B6E.30709@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Exactly what is wanted with hostfs UID/GID operation
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 13 Oct 2003 15:47:10 -0700
To: user-mode-linux-devel@lists.sourceforge.net

There have been a number of messages dancing around regarding 
UID/GID/permissions with hostfs.

My original message was that I had a set of patches that fixed bugs with 
UID/GID mappings when UML is run as "root".  If UML is not run as root, 
then is is impossible to create files in the hostfs area that are not 
owned by the UML "user" on the host.

The reason for my fixes was that even with UML running as "root" the 
UID/GID did not always translate down cleanly.  My "fix" was basically 
to enclose all file IO operatoins that could "create" new files or 
directories inside of seteuid/setegid calls so that UML itself became 
the user desired during the IO calls.  This seems to work well, but 
again it requires UML run as root.

Some people have talked about other ways to store UID/GID in hostfs.  I 
think this is a completely different thing.  My goal was to make the 
filesystem transparent so that UID/GID were visible and preserved 
between the host and client access points.  Other seem to want some sort 
of "mapping layer" so that the UML client "sees" UID/GID that follows 
it, but that the actual host always has a single UID.

 From my point of view, there are five options here.

1.  Leave the hostfs UID/GID mappings as is (ie. broken).  They are good 
enough to store files and boot from, although some applications seems to 
complain.

2.  Do a patch like I have the keeps the UID/GID "correct" thru to the 
host assuming that UML is running as root.  This is a bit of a security 
risk for "untrusted" UML situations such as "mass hosting" (which is 
part of what we do).

3.  Do patch #2 so that UML is setuid root.  This is a very small amount 
  better in the security department than #2, but still has a lot of 
potential "holes".

4.  Do patch #2 and build a "helper" process that is root than mangles 
file ownership externally.  This is probably much harder to breach but 
might be a bit of a performance bottleneck.  Implementation wise, it 
would just be a pair of pipes and an RPC across them to do the actual IO 
operations.

5.  Build a "mapping layer" that stores the UID/GID external to the 
files themselves.  This is what some people are talking about.  There 
are a whole slew of ways to implement this, but I would vote for 
simplicity and "minimal prerequisites" over performance.  A parellel set 
of directories with text files containing the UID/GID would be one 
approach.  I would vote against anything that requires a formal database 
setup even though that would outperform other options.

Everything here except for #2/#3 has SMP ramifications.  I think that 
just seteuid/setegid will work SMP pretty much as is in that each thread 
in SMP can change independently.  You have to be careful how you 
transition down UID/GID structs (statics are bad) but this is probably 
doable.  I am not personally running UML SMP so I don't have a lot of 
experience here (it is just too convenient to be single-threaded).

I am looking for some discussion here before I start up a formal patch 
set, so any input would be appreciated.

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
D3, U2, jBase Virtual Servers.    Off-site backup over the internet.
Develop/test/deploy from $20/mo.  Fast, secure, cheaper than tape.
http://mirroredservers.com        http://mirroredbackup.com



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

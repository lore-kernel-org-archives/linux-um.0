Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAg2F-0006z8-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 18:37:39 -0700
Received: from bay7-f71.bay7.hotmail.com ([64.4.11.71] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAg1S-0006P4-Sk
	for User-mode-linux-devel@lists.sourceforge.net; Fri, 17 Oct 2003 18:36:50 -0700
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F71MKk9LqOVoQc000091eb@hotmail.com>
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
Date: Sat, 18 Oct 2003 01:31:36 +0000
To: adam@doogie.org
Cc: User-mode-linux-devel@lists.sourceforge.net

Adam Heath wrote:
>On Tue, 14 Oct 2003, Steve Schmidtke wrote:
> >   filemap=file,10,/proc/cpuinfo 10</proc/cpuinfo \
>
>I have some unfinished code to make uml read a config file.  It fits in 
>nicely
>with the cmdline parsing.

It may help with half the problem here.  There are two parts, the
"filemap=10/proc/cpuinfo" config string to be parsed within the UML, and the 
"10</proc/cpuinfo" redirection in the parent shell.  The uglyness I see is 
the duplication that must be syncronized between the two.

It would be nice if a chroot wrapper could open the files and pass the 
"filemap=" config strings to your config parser.  Something like this:

  umlwrap -map=/proc/cpuinfo -bind=/tmp/uml.ctl \
  -config=tmp.file -- ./linux 32M config=tmp.file ...

The hypothetical umlwrap program opens /proc/cpuinfo (on fd 5, say -- you 
would no longer have to define it) and /tmp/uml.ctl (on fd 6).  The umlwrap 
program then builds the config strings "filemap=file,5,/proc/cpuinfo" and 
"filemap=file,6,/tmp/uml.ctl" and writes them out to tmp.file for the UML to 
pick up.  No more messing around with arbitrary file descriptors on the 
command line.

Though a bonus would be if your config file parser could handle input from a 
given fd as well. :)

Steve Schmidtke

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

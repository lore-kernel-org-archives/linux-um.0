Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CE7yh-0002RZ-3R for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 08:08:47 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CE7xN-0001LV-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 08:08:46 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] T-mode processes
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410031704.29051.blaisorblade_spam@yahoo.it>
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
Date: Sun, 3 Oct 2004 17:04:29 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Sunday 03 October 2004 02:26, Michael Richardson wrote:
> The following seems to get rid of the processes:
>
> ps ax | grep linux | awk '{print $1;}' | while read pid
> do
>   ( strace -p $pid ) &
> done
>
> So, this tells me that kill-9 can't kill a process which is being
> strace'ed. I really think that this is a bug.
Well, you should probably try kill -CONT before doing kill -9 (i.e. -KILL). 
Actually it makes sense that strace -p *does* kill -CONT.

> We also continue to have an issue with the /proc/PID/environ file not being
> owned by the process involved.
I'm looking at the permission in your listing and in my linux, and I don't see 
anything strange. Plus, I don't understand what you mean with "a file owned 
by a certain process".

Do you mean "I start the process with uid build and /proc/PID/* has uid root 
while it should have uid build"?

If you mean this, the answer is that you seem to be starting UML with one id 
and making it run with another UID. At least, I see this permission situation 
with the X Font Server:

root # ls -la /proc/1164/
totale 0
dr-xr-xr-x    3 xfs  xfs  0 ott  3 17:03 .
dr-xr-xr-x  125 root root 0 ott  3  2004 ..
-r--r--r--    1 root root 0 ott  3 17:03 cmdline
lrwxrwxrwx    1 root root 0 ott  3 17:03 cwd -> /
-r--------    1 root root 0 ott  3 17:03 environ
lrwxrwxrwx    1 root root 0 ott  3 17:03 exe -> /usr/X11R6/bin/xfs
dr-x------    2 root root 0 ott  3 17:03 fd
-r--r--r--    1 root root 0 ott  3 17:03 maps
-rw-------    1 root root 0 ott  3 17:03 mem
-r--r--r--    1 root root 0 ott  3 17:03 mounts
lrwxrwxrwx    1 root root 0 ott  3 17:03 root -> /
-r--r--r--    1 root root 0 ott  3 17:03 stat
-r--r--r--    1 root root 0 ott  3 17:03 statm
-r--r--r--    1 root root 0 ott  3 17:03 status

> This keeps our automatic cleaner from 
> getting the processes which are strays.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYivM-0003aQ-D9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 03:06:12 -0700
Received: from ns1.auto.ucl.ac.be ([130.104.239.135] helo=zlop.auto.ucl.ac.be)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BYivL-0001LY-Ha for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 03:06:11 -0700
Message-ID: <40C99B22.2010709@auto.ucl.ac.be>
From: Vincent Guffens <guffens@auto.ucl.ac.be>
MIME-Version: 1.0
Subject: Re: [uml-devel] Hi people. A kernel bug in the vanilla kernel
References: <1194.83.109.2.104.1086945968.squirrel@nepa.nlc.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 11 Jun 2004 13:44:34 +0200
To: stian@nixia.no
Cc: user-mode-linux-devel@lists.sourceforge.net

I've just tried it in linux-2.4.24-um1 and it does not freeze anything. 
The program prints dots and stars here and there.

uml:~# uname -a
Linux uml 2.4.24-1um #46 Thu May 6 13:54:24 GMT 2004 i686 unknown

uml:~# /mnt/home/vinsz/tmp/bug
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
...............*...................................................
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
...................................................................
..................................................*................
...........................................*.......................
...................................................................
....................

stian@nixia.no wrote:
> I'm currently on a small vaccation so I'm quite limited in Internett
> connection and alike. I come across a kernel-bug in 2.4.x and 2.6.x
> kernels and wondered if the same problemes occures inside UML. Could
> somebody just take a small peek?
> 
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108681568931323&w=2
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905
> 
> 
> Simple compile the small program that is in the report on the gcc bugzilla
> system and run it inside UML and see if runs or freezes the UML.
> 
> 
> 
> Stian Skjelstad
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
>>From Windows to Linux, servers to mobile, InstallShield X is the
> one installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 



-- 
				Vincent Guffens
				PhD Student UCL/CESAME
				tel:   +32 10 47 80 30
Value your freedom, or you will lose it, teaches history.
"Don't bother us with politics," respond those who don't want to learn.
	      	-- Richard M. Stallman



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

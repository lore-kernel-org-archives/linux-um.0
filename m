Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYird-00036S-9T for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 03:02:21 -0700
Received: from [207.44.234.19] (helo=cpanel.bh-link.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BYird-0000kh-0A
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Jun 2004 03:02:21 -0700
Message-ID: <40C98359.1050002@almahdi.cc>
From: Ali Almahdi <ali@almahdi.cc>
MIME-Version: 1.0
Subject: Re: [uml-devel] Hi people. A kernel bug in the vanilla kernel
References: <1194.83.109.2.104.1086945968.squirrel@nepa.nlc.no>
In-Reply-To: <1194.83.109.2.104.1086945968.squirrel@nepa.nlc.no>
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
Date: Fri, 11 Jun 2004 13:03:05 +0300
To: stian@nixia.no
Cc: user-mode-linux-devel@lists.sourceforge.net

I have tested this on one of my umls (Linux version 2.6.4-1um), It 
didn't crash..
Here is the output I got..
--------------- Output -------------------
#./a.out
.................................................*..............
.................................................................
.................................................................
.................................................................
.....Floating point exception

----------- Output ends here ----------------

stian@nixia.no wrote:

>I'm currently on a small vaccation so I'm quite limited in Internett
>connection and alike. I come across a kernel-bug in 2.4.x and 2.6.x
>kernels and wondered if the same problemes occures inside UML. Could
>somebody just take a small peek?
>
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=108681568931323&w=2
>http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905
>
>
>Simple compile the small program that is in the report on the gcc bugzilla
>system and run it inside UML and see if runs or freezes the UML.
>
>
>
>Stian Skjelstad
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by the new InstallShield X.
>>From Windows to Linux, servers to mobile, InstallShield X is the
>one installation-authoring solution that does it all. Learn more and
>evaluate today! http://www.installshield.com/Dev2Dev/0504
>_______________________________________________
>User-mode-linux-devel mailing list
>User-mode-linux-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

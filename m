Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BclBJ-0007xj-Uy for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 06:19:21 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BclBJ-00018h-LU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jun 2004 06:19:21 -0700
Message-ID: <40D831B2.8060108@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic: handle_trap - failed to wait at end
	of syscall, errno = 4, status = 1151
References: <000f01c45593$35c20e00$0201a8c0@hawk>
	<20040619173952.GA7740@ccure.user-mode-linux.org>
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
Date: Tue, 22 Jun 2004 09:18:42 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

would this be something simple like

do {
    err = waitpid(pid, &status, WUNTRACED);
} while ((err < 0) && (errno == EINTR));

strangely I am seeing this error also w/ host 2.4.20-24.8 + 
host-skas3a-2.4.25.patch and 2.4.22+uml_patch-2.4.24-1.

regards, GSM

Jeff Dike wrote:
> On Fri, Jun 18, 2004 at 07:19:57PM -0500, Christopher S. Aker wrote:
> 
>>Kernel panic: handle_trap - failed to wait at end of syscall, errno = 4, status =
>>1151
>>
>>        err = waitpid(pid, &status, WUNTRACED);
>>        if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
>>                panic("handle_trap - failed to wait at end of syscall, "
>>                      "errno = %d, status = %d\n", errno, status);
> 
> 
> Easy diagnosis - errno 4 is EINTR, this wasn't checking for that and redoing
> the wait.
> 
> I've been adding EINTR safety in a bit at a time, just hadn't noticed this
> yet.
> 
> 				Jeff
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

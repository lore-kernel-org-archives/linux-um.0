Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMn56-0004AJ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 03:34:40 -0800
Received: from adsl-b4-97-234.telepac.pt ([81.193.97.234] helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AMn4T-0004DC-UB
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 03:34:02 -0800
Message-ID: <3FBCA6DA.7020407@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] skas3-related crash of the week
References: <877k1w85vh.fsf@amaterasu.srvr.nix> <3FBBD9CA.2010303@vgertech.com>
In-Reply-To: <3FBBD9CA.2010303@vgertech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 20 Nov 2003 11:34:50 +0000
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Nix <nix@esperi.org.uk>, user-mode-linux-devel@lists.sourceforge.net



Nuno Silva wrote:
> Hi!!
> 
> Nix wrote:
> 
>> Using unmodified 2.4.22-6. sshed in through the firewall on the UML
>> instance, with tty logging enabled: typing exit on the last sshed-in
>> console froze the box yielded this on the console before UML died:
>>
>> Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 9
>>
>> Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 9
>>

I've found a log with the error, it's a bit different from yours:

Kernel panic: save_registers - saving registers failed, errno = 3

Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 3

In idle task - not syncing

--------------------------------

 From the screen(1) logs this was a few minutes after the boot and this 
UML should be mostly idle. I only have this log and no backtraces... not 
  very helpfull :(

Regards,
Nuno Silva



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

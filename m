Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRH9c-0007K1-88 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 May 2004 14:02:08 -0700
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BRH9b-0001El-RC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 May 2004 14:02:07 -0700
Received: from zbl6c012.us.nortel.com (zbl6c012.corpeast.baynetworks.com
	[132.245.205.62])
	by zcars0m9.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP
	id i4LL1wE11470 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 May 2004 17:01:58 -0400 (EDT)
Message-ID: <40AE6E43.2000306@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] build errors with 2.4.24 + uml-patch-2.4.24-3
References: <40AE5B69.9030209@nortelnetworks.com>
	<40AE630C.5060209@nortelnetworks.com>
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
Date: Fri, 21 May 2004 17:01:55 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Joe Marzot <gmarzot@nortelnetworks.com>

seems to be stuck in file_io doing a read after xterm_open

Program received signal SIGINT, Interrupt.
0xa017ff74 in read ()
     at /usr/local/builds/linux-2.4.24/include/linux/if_vlan.h:122
122     }
(gdb) where
#0  0xa017ff74 in read ()
     at /usr/local/builds/linux-2.4.24/include/linux/if_vlan.h:122
#1  0xa125f970 in ?? ()
#2  0xa00d455a in os_read_file (fd=9, buf=0xa125f908, len=4) at file.c:503
#3  0xa00c3ec8 in run_helper (pre_exec=0xfffffe00, pre_data=0xfffffe00,
     argv=0xfffffe00, stack_out=0xa125f970) at helper.c:91
#4  0xa0107b3a in xterm_open (input=1, output=1, primary=1, d=0xa03337e0,
     dev_out=0xfffffe00) at xterm.c:120

Joe Marzot wrote:
> 
> I got around this by moving the endif in aio.c to the end and turning 
> off CONFIG_HUMFS (not sure if other parts of HOSTFS or EXTERNFS) depedn 
> on it....
> 
> But now the UML guest will not boot beyond the point where it pops up 
> the xterm...then the xterm remains blank.
> 
> Has anyone else had success with this combo?
> 
> I have attached my .config
> 
> -GSM
> 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

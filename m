Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1SbasD-0000sc-Jc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 17:15:21 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SbasC-0007zB-Tc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 17:15:21 +0000
Message-ID: <4FCCED0A.8080605@panasas.com>
Date: Mon, 4 Jun 2012 20:14:50 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1338809738-18967-1-git-send-email-jslaby@suse.cz>
	<1338809738-18967-14-git-send-email-jslaby@suse.cz>
	<4FCCA3A6.8080608@nod.at> <4FCCD224.1020307@suse.cz>
	<4FCCD44A.3090500@nod.at> <4FCCD70D.5010908@suse.cz>
	<4FCCD774.5040003@nod.at> <4FCCE1D4.7080805@panasas.com>
	<4FCCE255.4080705@nod.at> <4FCCE866.7050203@panasas.com>
	<4FCCEAE5.9000801@nod.at>
In-Reply-To: <4FCCEAE5.9000801@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 13/24] TTY: um/line, use tty from tty_port
To: Richard Weinberger <richard@nod.at>
Cc: Jiri Slaby <jirislaby@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, alan@linux.intel.com

On 06/04/2012 08:05 PM, Richard Weinberger wrote:

> Am 04.06.2012 18:55, schrieb Boaz Harrosh:
>> No still crashing the same, way. BTW I do not have a systemd Distro. It's
>> plain old FC12. Though in the lab I have the same crash with FC15.
>>
>> The crash is immediately after I login at the initial prompt. (every time)
> 
> Okay, I'll test my patches with FC12 too. :-\
> 


Thanks. Do you need help with an image?

>> Here is the crash print, what ever that is worth in UML.
>> (Can we make the crash dump stack trace a bit less terrible?)
> 
> -ENOPATCH. :-)
> Feel free to send one.
> 


:-) It's always the: "how much time I spend on saving time later?"

But I promise I'll do it one day.

> Thanks,
> //richard
> 
> 


Thanks
Boaz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


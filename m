Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1SbaI3-0001Qy-BX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 16:37:59 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SbaHy-0006vs-5s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 16:37:59 +0000
Message-ID: <4FCCE442.4020801@panasas.com>
Date: Mon, 4 Jun 2012 19:37:22 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1338809738-18967-1-git-send-email-jslaby@suse.cz>
	<1338809738-18967-14-git-send-email-jslaby@suse.cz>
	<4FCCA3A6.8080608@nod.at> <4FCCD224.1020307@suse.cz>
	<4FCCD44A.3090500@nod.at> <4FCCD70D.5010908@suse.cz>
	<4FCCD774.5040003@nod.at> <4FCCE1D4.7080805@panasas.com>
	<4FCCE255.4080705@nod.at>
In-Reply-To: <4FCCE255.4080705@nod.at>
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

On 06/04/2012 07:29 PM, Richard Weinberger wrote:

> Am 04.06.2012 18:27, schrieb Boaz Harrosh:
>> On 06/04/2012 06:42 PM, Richard Weinberger wrote:
>>
>>> Am 04.06.2012 17:41, schrieb Jiri Slaby:
>>>> Hmm, I remember. I suggest you to split the patch into several pieces.
>>>> For example moving the code from ->open into ->install can be done
>>>> separately. Otherwise it's hard to tell what's wrong with the patch as
>>>> a whole.
>>>>
>>>> Also, it would be good to see the patch rebased on the top of my
>>>> patch, because tty_port_set/get pieces would be gone from your patch too.
>>>
>>> Okay, I'll redo it!
>>> I've a much cleaner version in my local queue.
>>>
>>
>>
>> Can you send it my way, I'm still running broken, 3.4 Based ?
>>
> 
> Can you please first give Jiri's patches a try?
> 
> [PATCH 12/24] TTY: um/line, add tty_port
> [PATCH 13/24] TTY: um/line, use tty from tty_port
> 


OK Will do

Boaz

> Thanks,
> //richard
> 



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


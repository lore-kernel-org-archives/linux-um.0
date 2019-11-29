Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iabwW-00029Q-06
 for linux-um@lists.infradead.org; Fri, 29 Nov 2019 08:48:01 +0000
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6]
 helo=jain.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <anton.ivanov@cambridgegreys.com>)
 id 1iabwP-0001X6-7r
 for linux-um@lists.infradead.org; Fri, 29 Nov 2019 08:47:53 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
 by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
 (envelope-from <anton.ivanov@cambridgegreys.com>) id 1iabwN-0000rZ-2Z
 for linux-um@lists.infradead.org; Fri, 29 Nov 2019 08:47:53 +0000
Subject: Re: I get 5.4 fail to start
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
Message-ID: <f0f44705-5c43-89b8-ecd8-1dba5e073f8d@cambridgegreys.com>
Date: Fri, 29 Nov 2019 08:47:50 +0000
MIME-Version: 1.0
In-Reply-To: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>



On 28/11/2019 17:27, Anton Ivanov wrote:
> Hi all,
> 
> I get 5.4 fail to start. 5.4 gives:
> 
> Checking that ptrace can change system call numbers...check_ptrace : 
> child exited with exitcode 6, while expecting 0; status 0x67f
> Aborted
> 
> And stops right at the very start.
> 
> I do not recall anything there changing in the 5.2 - 5.4 timeframe so 
> this is weird.
> 
> Ideas?
> 

Two problems:

1. The code in stop_ptraced_child is wrong

if (!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode))

This is incorrect - you can use the WEXITSTATUS(status) macro only if 
WIFEXITED(status) has returned true.

2. The second problem is that for whatever reason after going to 5.4 
that stopped returning true. No idea what's happening there.

After I fix (1), I get everything to work as intended.

I am going to play a bit with a patch which addresses (1) and submit it 
if I am happy with it. If anyone has any ideas about (2) - please shout.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


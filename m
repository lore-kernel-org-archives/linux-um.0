Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXzFq-0001EM-M2	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 03:24:50 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DXzFo-0001Ma-Sc	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 03:24:50 -0700
Message-ID: <4289C66C.9000709@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: uml-general-protection-fault even more kludgy
 but mergeable
References: <200505170005.43629.blaisorblade@yahoo.it>
	<20050517100317.GB20584@bytesex>
In-Reply-To: <20050517100317.GB20584@bytesex>
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
Date: Tue, 17 May 2005 12:24:44 +0200
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Gerd Knorr wrote:
>>So, in practice, it's correct to call bad_segv() as done in the patch, but we 
>>miss some cases. Only this time I've verified this well enough that I feel we 
>>could merge your patch. However, I've not found any possible *realistic* 
>>source of general protection faults. Especially I didn't find what expected 
>>(i.e. I/O errors).
> 
> 
> The case I trapped into was an attempt to access I/O ports of a
> process running inside the uml.  The uml kernel then tried to
> handle that as page fault, which didn't work very well ...
> 
>   Gerd
> 
Unfortunately, I can't find the previous mails about this. So, maybe I'm
totally wrong. If so, please discard this mail.

Gerd, did you see the problem in SKAS3 on i386? If so, it would be nice to
see what happens in SKAS0.

I saw similar problems regarding bad LDT-descriptors. Processes using a bad
descriptor loop on page_fault.

The real fix for this is to add trap_no to the info, that is read from host
by PTRACE_FAULTINFO. With this info, UML can distinguish between real page
faults and other SIGSEGVs.

In SKAS0, UML already has the full info, as it retrieves the info from a
sigcontext.

Regards,
	Bodo


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

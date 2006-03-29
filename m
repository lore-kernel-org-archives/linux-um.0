Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOhQg-00004y-Qd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 12:38:10 -0800
Received: from www.scgiservices.com ([198.107.3.66] helo=www.sterlingcgi.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FOhQf-0002oc-Ld
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 12:38:10 -0800
Message-ID: <20060329123808.nlnz9h68pwg0s44s@www.scgiservices.com>
From: Anthony Brock <brocka@sterlingcgi.com>
Subject: Re: [uml-devel] Re: SMP skas requirements
References: <20060329043656.GA25520@ccure.user-mode-linux.org>
In-Reply-To: <20060329043656.GA25520@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
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
Date: Wed, 29 Mar 2006 12:38:08 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Quoting Jeff Dike <jdike@addtoit.com>:
> On Wed, Mar 29, 2006 at 12:40:00AM +0200, Blaisorblade wrote:
>> Finally, I'd like to get devshm merged if there aren't problems with the
>> code.
>
> That one needs to check if /dev/shm is present, and fall back to /tmp
> if not.

Are you proposing that virtual servers automatically using /dev/shm if 
available and only falling back to the $TMP variable and /tmp directory 
if not? Or would this keep the use of $TMP if present and fall back to 
/dev/shm followed by /tmp?

I'm asking because I've optimized multiple host machines to offer a 
ramfs for virtual servers. This gives me locked memory (which still 
provides a significant performance improvement over time) for each 
instance. I would prefer to avoid using tmpfs if possible.

Alternatively, some means for preventing the host from swapping out 
instances would be appreciated.

Tony



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

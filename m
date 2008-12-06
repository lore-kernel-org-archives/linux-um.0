Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L8lmj-00020p-Ah
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Dec 2008 01:16:41 +0000
Received: from ti-out-0910.google.com ([209.85.142.185])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L8lmf-0004lm-Qd for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Dec 2008 01:16:41 +0000
Received: by ti-out-0910.google.com with SMTP id y6so180179tia.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 05 Dec 2008 17:16:34 -0800 (PST)
Message-ID: <2375c9f90812051716w6974a18asd4c34cb47bd64aa4@mail.gmail.com>
Date: Sat, 6 Dec 2008 01:16:34 +0000
From: "=?UTF-8?Q?Am=C3=A9rico_Wang?=" <xiyou.wangcong@gmail.com>
In-Reply-To: <20081202121707.e1623f89.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <20081129100830.GA24128@balbir.in.ibm.com>
	<84144f020811290221g947f836n4fe3435676425ee@mail.gmail.com>
	<20081129122039.GA31635@balbir.in.ibm.com>
	<20081202121707.e1623f89.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH][UML] Boot broken due to buffer overrun
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi, stable@kernel.org, balbir@linux.vnet.ibm.com

On Tue, Dec 2, 2008 at 8:17 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 29 Nov 2008 17:50:39 +0530
> Balbir Singh <balbir@linux.vnet.ibm.com> wrote:
>
>> * Pekka Enberg <penberg@cs.helsinki.fi> [2008-11-29 12:21:46]:
>>
>> > Hi Balbir,
>> >
>> > On Sat, Nov 29, 2008 at 12:08 PM, Balbir Singh
>> > <balbir@linux.vnet.ibm.com> wrote:
>> > > mconsole_init() passed 256 bytes as length in os_create_unix_socket, while
>> > > the sizeof UNIX_PATH_MAX is 108. This patch fixes that problem and avoids
>> > > a big overrun bug reported on UML bootup.
>> >
>> > Maybe mention that ->sun_path in struct sockaddr_un is UNIX_PATH_MAX
>> > long which causes the problem?
>> >
>>
>> Yes, the changelog can definitely add that to the changelog, I'll
>> resend the patch if Jeff asks for it.
>
> Jeff's been quiet lately - I'll merge this one.


Yes, indeed.

>
> I also tagged it for -stable, subject to Jeff's OK.  I'm wondering why
> this wasn't observed in earlier kernels?

Maybe because mconsole is not often used for uml? :)

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

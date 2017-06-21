Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <natale.patriciello@gmail.com>) id 1dNbAV-0006xq-OI
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2017 08:39:19 +0000
Received: from mail-qk0-f193.google.com ([209.85.220.193])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dNbAS-0001T5-Vq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2017 08:39:19 +0000
Received: by mail-qk0-f193.google.com with SMTP id d14so14342962qkb.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Jun 2017 01:39:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D352734E-E991-4338-A5B3-94E840039841@m3y3r.de>
References: <1497923806.7300.2.camel@m3y3r.de>
	<98803c66-4a36-a95f-5a1b-51a40de7a3e6@nod.at>
	<1497948550.7300.5.camel@m3y3r.de>
	<25066617-df15-6d21-713c-1ede1e953448@nod.at>
	<1497981874.22112.20.camel@test-lenovo>
	<4d431238-28c7-3680-42f2-f7cf32acbc86@nod.at>
	<2fc7383c-852a-be3c-f934-b125fe9bdba2@nod.at>
	<1497988398.22550.5.camel@test-lenovo>
	<D352734E-E991-4338-A5B3-94E840039841@m3y3r.de>
From: Natale Patriciello <natale.patriciello@gmail.com>
Date: Wed, 21 Jun 2017 10:39:11 +0200
Message-ID: <CAAyZ8nrQiu3w_SyCBWLbjjbsb+_KwhFnHkK7hFMpB7UcDsBCsQ@mail.gmail.com>
Subject: Re: [uml-devel] um: PTRACE_SETREGSET failure with XSTATE on
 Kabylake CPU
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>

2017-06-20 22:13 GMT+02:00 Thomas Meyer <thomas@m3y3r.de>:
>
>> Am 20.06.2017 um 21:53 schrieb Yu-cheng Yu <yu-cheng.yu@intel.com>:
>>
>>> On Tue, 2017-06-20 at 20:59 +0200, Richard Weinberger wrote:
>>> Yu-cheng,
>>>
>>>> Am 20.06.2017 um 20:17 schrieb Richard Weinberger:
>>>> Yu-cheng,
>>>>
>>>> Am 20.06.2017 um 20:04 schrieb Yu-cheng Yu:
>>>>>>> So to summarize:
>>>>>>>
>>>>>>> - PTRACE_GETREGSET with NT_X86_XSTATE gets 832 and return 832, with no
>>>>>>> error.
>>>>>>>
>>>>>>> - PTRACE_SETREGSET get 832 (sizeof struct _xstate) but wants at least
>>>>>>> 1088, otherwise it will fail with -EFAULT (why not -EINVAL?)
>>>>>>>
>>>>>>> Ideas?

[cut text and CC'ed persons]

It is funny to see that this problem was firstly reported here [1] in
February 2017 without being considered until someone else bought a new
laptop :)

Anyway, thank you for digging into this; my temporary workaround at
the time was to use always the *_i387_registers functions.

HTH,
Nat

[1] https://sourceforge.net/p/user-mode-linux/mailman/message/35663374/

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


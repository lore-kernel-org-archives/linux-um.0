Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <5285838C.6070508@asianux.com>
Date: Fri, 15 Nov 2013 10:14:36 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
References: <alpine.LNX.2.00.1310150330350.9078@eggly.anvils>
	<528308E8.8040203@asianux.com>
	<alpine.LNX.2.00.1311132041200.1785@eggly.anvils>
	<52847237.5030405@asianux.com> <52847CD5.1030105@asianux.com>
In-Reply-To: <52847CD5.1030105@asianux.com>
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
Subject: Re: [uml-devel] [PATCH] arch: um: kernel: skas: mmu: remove
 pmd_free() and pud_free() for failure processing in init_stub_pte()
To: Hugh Dickins <hughd@google.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, uml-user <user-mode-linux-user@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>

On 11/14/2013 03:33 PM, Chen Gang wrote:
> On 11/14/2013 02:48 PM, Chen Gang wrote:
>>> >From the look of it, if an error did occur in init_stub_pte(),
>>>> then the special mapping of STUB_CODE and STUB_DATA would not
>>>> be installed, so this area would be invisible to munmap and exit,
>>>> and with your patch then the pages allocated likely to be leaked.
>>>>
>> It sounds reasonable to me: "although 'pgd' related with 'mm', but they
>> are not installed". But just like you said originally: "better get ACK
>> from some mm guys".
>>
>>
>> Hmm... is it another issue: "after STUB_CODE succeeds, but STUB_DATA
>> fails, the STUB_CODE will be leaked".
>>
>>
>>>> Which is not to say that the existing code is actually correct:
>>>> you're probably right that it's technically wrong.  But it would
>>>> be very hard to get init_stub_pte() to fail, and has anyone
>>>> reported a problem with it?  My guess is not, and my own
>>>> inclination to dabble here is zero.
>>>>
>> Yeah.
>>
> 
> If we can not get ACK from any mm guys, and we have no enough time
> resource to read related source code, for me, I still recommend to
> remove p?d_free() in failure processing.
> 

Oh, I am very sorry to Hugh and Richard, I make a mistake in common
sense: I recognized incorrect members (I treated Hugh as Richard), Hugh
is "mm guys".

Next time, I should see the mail carefully, not only for contents, but
also for senders.

Sorry again to both of you.

Thanks.

> In the worst cases, we will leak a little memory, and no any other
> negative effect, it is an executable way which is no any risks.
> 
> For current mm implementation, it seems we can not assume any thing,
> although they sounds (or should be) reasonable (include what you said
> about mm).
> 
> 
> Thanks.
> 


-- 
Chen Gang

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


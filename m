Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 24 Apr 2018 10:32:53 +0200
Message-ID: <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use
 force_sig_fault in relay_signal.
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-ID: <linux-um.lists.infradead.org>

On Fri, Apr 20, 2018 at 6:06 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
>
> On 04/20/18 15:38, Eric W. Biederman wrote:
>>
>> Today user mode linux only works on x86 and x86_64 and this allows
>> simplifications of relay_signal.
>
>
> I believe someone recently fixed the ARM port. I have not had the time to
> try the fixes though.

Huh? UML is for ages x86 only.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


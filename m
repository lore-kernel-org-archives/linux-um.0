Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9S9h-00082l-Qr
 for linux-um@lists.infradead.org; Tue, 09 Feb 2021 12:30:11 +0000
Subject: Re: [PATCH] kunit: tool: Disable PAGE_POISONING under --alltests
References: <20210209071034.3268897-1-davidgow@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <91207d64-e50f-872d-10db-55153da41aec@suse.cz>
Date: Tue, 9 Feb 2021 13:30:07 +0100
MIME-Version: 1.0
In-Reply-To: <20210209071034.3268897-1-davidgow@google.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com

On 2/9/21 8:10 AM, David Gow wrote:
> kunit_tool maintains a list of config options which are broken under
> UML, which we exclude from an otherwise 'make ARCH=um allyesconfig'
> build used to run all tests with the --alltests option.
> 
> Something in UML allyesconfig is causing segfaults when page poisining
> is enabled (and is poisoning with a non-zero value). Previously, this
> didn't occur, as allyesconfig enabled the CONFIG_PAGE_POISONING_ZERO
> option, which worked around the problem by zeroing memory. This option
> has since been removed, and memory is now poisoned with 0xAA, which
> triggers segfaults in many different codepaths, preventing UML from
> booting.
> 
> Note that we have to disable both CONFIG_PAGE_POISONING and
> CONFIG_DEBUG_PAGEALLOC, as the latter will 'select' the former on
> architectures (such as UML) which don't implement __kernel_map_pages().
> 
> Ideally, we'd fix this properly by tracking down the real root cause,
> but since this is breaking KUnit's --alltests feature, it's worth
> disabling there in the meantime so the kernel can boot to the point
> where tests can actually run.

Agree on both arguments :)

> Fixes: f289041ed4 ("mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO")
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

...

> Disabling PAGE_POISONING fixes this. The issue can't be repoduced with
> just PAGE_POISONING, there's clearly something (or several things) also
> enabled by allyesconfig which contribute. Ideally, we'd track these down
> and fix this at its root cause, but in the meantime it'd be nice to
> disable PAGE_POISONING so we can at least get the kernel to boot. One
> way would be to add a 'depends on !UML' or similar, but since
> PAGE_POISONING does seem to work in the non-allyesconfig case, adding it
> to our list of broken configs seemed the better choice.
> 
> Thoughts?

Agreed that it's better to use kunit-specific config file instead of introducing
such workaround dependencies in Kconfig proper.

> (Note that to reproduce this, you'll want to run
> ./tools/testing/kunit/kunit.py run --alltests --raw_output
> It also depends on a couple of other fixes which are not upstream yet:
> https://www.spinics.net/lists/linux-rtc/msg08294.html
> https://lore.kernel.org/linux-i3c/20210127040636.1535722-1-davidgow@google.com/
> 
> Cheers,
> -- David
> 
>  tools/testing/kunit/configs/broken_on_uml.config | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
> index a7f0603d33f6..690870043ac0 100644
> --- a/tools/testing/kunit/configs/broken_on_uml.config
> +++ b/tools/testing/kunit/configs/broken_on_uml.config
> @@ -40,3 +40,5 @@
>  # CONFIG_RESET_BRCMSTB_RESCAL is not set
>  # CONFIG_RESET_INTEL_GW is not set
>  # CONFIG_ADI_AXI_ADC is not set
> +# CONFIG_DEBUG_PAGEALLOC is not set
> +# CONFIG_PAGE_POISONING is not set
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


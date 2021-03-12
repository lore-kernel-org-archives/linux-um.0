Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKezr-00BARs-Ka
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 10:26:21 +0000
Message-ID: <0375326f2f20dc82c056d41faee97489a1a03677.camel@sipsolutions.net>
Subject: Re: [PATCH 2/6] module: add support for CONFIG_MODULE_DESTRUCTORS
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 12 Mar 2021 11:26:17 +0100
In-Reply-To: <20210312104627.8b2523b0593c.Ib0fb7906e3d7bd69ebe5eb877e2e9f33ef915d4b@changeid>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
 <20210312104627.8b2523b0593c.Ib0fb7906e3d7bd69ebe5eb877e2e9f33ef915d4b@changeid>
MIME-Version: 1.0
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
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org

On Fri, 2021-03-12 at 10:55 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> At least in ARCH=um with CONFIG_GCOV (which writes all the
> coverage data directly out from the userspace binary rather
> than presenting it in debugfs) it's necessary to run all
> the atexit handlers (dtors/fini_array) so that gcov actually
> does write out the data.
> 
> Add a new config option CONFIG_MODULE_DESTRUCTORS that can
> be selected via CONFIG_WANT_MODULE_DESTRUCTORS that the arch
> selects (this indirection exists so the architecture doesn't
> have to worry about whether or not CONFIG_MODULES is on).
> Additionally, the architecture must then (when it exits and
> no more module code can run) call run_all_module_destructors
> to run the code for all modules that are still loaded. When
> modules are unloaded, the handlers are called as well.

Oops, I forgot to add this bit to the patch:

--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -16,6 +16,8 @@ SECTIONS {
 
        .init_array             0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
+       .fini_array             0 : ALIGN(8) { *(SORT(.fini_array.*)) *(.fini_array) }
+
        __jump_table            0 : ALIGN(8) { KEEP(*(__jump_table)) }
 
        __patchable_function_entries : { *(__patchable_function_entries) }


Should that be under the ifdef? .init_array isn't, even though it's only
relevant for CONFIG_CONSTRUCTORS.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Mar 2018 18:30:23 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [uml-devel] [PATCH] uml: Fix build with recent glibc
Message-ID: <20180301183023.00002ddf@intel.com>
In-Reply-To: <20180301030844.23448-1-andi@firstfloor.org>
References: <20180301030844.23448-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: richard@nod.at, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, jesse.brandeburg@intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, 28 Feb 2018 19:08:44 -0800
Andi Kleen <andi@firstfloor.org> wrote:

> From: Andi Kleen <ak@linux.intel.com>
> 
> Newer glibc did some include namespace "cleanups" and removed
> struct ucontext and friends. This already broke a lot of software,
> and UML seems to be the latest victim.
> 
> Use the typedefs which are still available. They also work on
> older glibcs.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

same patch that I sent on Feb 1st.  Hope you can get more traction than
I did.

https://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg10071.html

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


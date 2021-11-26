Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 4.9] hugetlbfs: flush TLBs correctly after huge_pmd_unshare
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <7a2feed4-7c73-c7ad-881e-c980235c8293@cambridgegreys.com>
Date: Fri, 26 Nov 2021 09:49:01 -0800
Message-Id: <C1607574-0A6F-4CEC-B488-795750EEF968@gmail.com>
References: <3BD89231-2CB9-4CE5-B0FA-5B58419D7CB8@gmail.com>
 <7a2feed4-7c73-c7ad-881e-c980235c8293@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>


> On Nov 26, 2021, at 2:21 AM, Anton Ivanov <anton.ivanov@cambridgegreys.com> wrote:
> 
> 
> 
> On 26/11/2021 06:08, Nadav Amit wrote:
>> Below is a patch to address CVE-2021-4002 [1] that I created to backport
>> to 4.9. The stable kernels of 4.14 and prior ones do not have unified
>> TLB flushing code, and I managed to mess up the arch code a couple of
>> times.
>> Now that the CVE is public, I would appreciate your review of this
>> patch. I send 4.9 for review - the other ones (4.14 and prior) are
>> pretty similar.
>> [1] https://www.openwall.com/lists/oss-security/2021/11/25/1
>> Thanks,
>> Nadav
> 
> I do not quite see the rationale for patching um
> 
> It supports only standard size pages. You should not be able to map a huge page there (and hugetlbfs).
> 
> I have "non-standard page size" somewhere towards the end of my queue, but it keeps falling through - not enough spare time to work on it.

Thanks for your review.

I did not look at the dependencies, so I did not even look if
hugetlbfs depends on !um.

Do you prefer that for um, I will just do a BUG()? I prefer
to have a stub just to avoid potential build issues.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um


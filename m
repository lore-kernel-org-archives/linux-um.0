Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5TO3-0000q1-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:11:11 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5TO1-00016e-Ss for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:11:11 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040909180519.61C2DA374@zion.localdomain>
Subject: [uml-devel] [patch 1/2] uml: fold ghash.h inside physmem.c
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
Date: Thu, 09 Sep 2004 20:05:18 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, hch@infradead.org, blaisorblade_spam@yahoo.it


Since we don't want ghash.h, just move the two needed macros (which don't use
the nasty fuzzy algorithm) to physmem.c. This should at all safe, and will
avoid ghash.h making its way inside 2.6.9. A separate patch will also fold the
macros inside their uses (there is just one defined hash), but since this hook
is not very used in this particular moment, I'll defer that to later. However
I'm posting the second one for review (but not for merging).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c |   80 +++++++
 uml-linux-2.6.8.1/include/linux/ghash.h          |  236 -----------------------
 2 files changed, 79 insertions(+), 237 deletions(-)

diff -L include/linux/ghash.h -puN include/linux/ghash.h~uml-fold-ghash-h-inside-physmem-c /dev/null
--- uml-linux-2.6.8.1/include/linux/ghash.h
+++ /dev/null	2004-06-25 17:47:25.000000000 +0200
@@ -1,236 +0,0 @@
-/*
- * include/linux/ghash.h -- generic hashing with fuzzy retrieval
- *
- * (C) 1997 Thomas Schoebel-Theuer
- *
- * The algorithms implemented here seem to be a completely new invention,
- * and I'll publish the fundamentals in a paper.
- */
-
-#ifndef _GHASH_H
-#define _GHASH_H
-/* HASHSIZE _must_ be a power of two!!! */
-
-
-#define DEF_HASH_FUZZY_STRUCTS(NAME,HASHSIZE,TYPE) \
-\
-struct NAME##_table {\
-	TYPE * hashtable[HASHSIZE];\
-	TYPE * sorted_list;\
-	int nr_entries;\
-};\
-\
-struct NAME##_ptrs {\
-	TYPE * next_hash;\
-	TYPE * prev_hash;\
-	TYPE * next_sorted;\
-	TYPE * prev_sorted;\
-};
-
-#define DEF_HASH_FUZZY(LINKAGE,NAME,HASHSIZE,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,KEYEQ,HASHFN)\
-\
-LINKAGE void insert_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	int ix = HASHFN(elem->KEY);\
-	TYPE ** base = &tbl->hashtable[ix];\
-	TYPE * ptr = *base;\
-	TYPE * prev = NULL;\
-\
-	tbl->nr_entries++;\
-	while(ptr && KEYCMP(ptr->KEY, elem->KEY)) {\
-		base = &ptr->PTRS.next_hash;\
-		prev = ptr;\
-		ptr = *base;\
-	}\
-	elem->PTRS.next_hash = ptr;\
-	elem->PTRS.prev_hash = prev;\
-	if(ptr) {\
-		ptr->PTRS.prev_hash = elem;\
-	}\
-	*base = elem;\
-\
-	ptr = prev;\
-	if(!ptr) {\
-		ptr = tbl->sorted_list;\
-		prev = NULL;\
-	} else {\
-		prev = ptr->PTRS.prev_sorted;\
-	}\
-	while(ptr) {\
-		TYPE * next = ptr->PTRS.next_hash;\
-		if(next && KEYCMP(next->KEY, elem->KEY)) {\
-			prev = ptr;\
-			ptr = next;\
-		} else if(KEYCMP(ptr->KEY, elem->KEY)) {\
-			prev = ptr;\
-			ptr = ptr->PTRS.next_sorted;\
-		} else\
-			break;\
-	}\
-	elem->PTRS.next_sorted = ptr;\
-	elem->PTRS.prev_sorted = prev;\
-	if(ptr) {\
-		ptr->PTRS.prev_sorted = elem;\
-	}\
-	if(prev) {\
-		prev->PTRS.next_sorted = elem;\
-	} else {\
-		tbl->sorted_list = elem;\
-	}\
-}\
-\
-LINKAGE void remove_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	TYPE * next = elem->PTRS.next_hash;\
-	TYPE * prev = elem->PTRS.prev_hash;\
-\
-	tbl->nr_entries--;\
-	if(next)\
-		next->PTRS.prev_hash = prev;\
-	if(prev)\
-		prev->PTRS.next_hash = next;\
-	else {\
-		int ix = HASHFN(elem->KEY);\
-		tbl->hashtable[ix] = next;\
-	}\
-\
-	next = elem->PTRS.next_sorted;\
-	prev = elem->PTRS.prev_sorted;\
-	if(next)\
-		next->PTRS.prev_sorted = prev;\
-	if(prev)\
-		prev->PTRS.next_sorted = next;\
-	else\
-		tbl->sorted_list = next;\
-}\
-\
-LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
-{\
-	int ix = hashfn(pos);\
-	TYPE * ptr = tbl->hashtable[ix];\
-	while(ptr && KEYCMP(ptr->KEY, pos))\
-		ptr = ptr->PTRS.next_hash;\
-	if(ptr && !KEYEQ(ptr->KEY, pos))\
-		ptr = NULL;\
-	return ptr;\
-}\
-\
-LINKAGE TYPE * find_##NAME##_hash_fuzzy(struct NAME##_table * tbl, KEYTYPE pos)\
-{\
-	int ix;\
-	int offset;\
-	TYPE * ptr;\
-	TYPE * next;\
-\
-	ptr = tbl->sorted_list;\
-	if(!ptr || KEYCMP(pos, ptr->KEY))\
-		return NULL;\
-	ix = HASHFN(pos);\
-	offset = HASHSIZE;\
-	do {\
-		offset >>= 1;\
-		next = tbl->hashtable[(ix+offset) & ((HASHSIZE)-1)];\
-		if(next && (KEYCMP(next->KEY, pos) || KEYEQ(next->KEY, pos))\
-		   && KEYCMP(ptr->KEY, next->KEY))\
-			ptr = next;\
-	} while(offset);\
-\
-	for(;;) {\
-		next = ptr->PTRS.next_hash;\
-		if(next) {\
-			if(KEYCMP(next->KEY, pos)) {\
-				ptr = next;\
-				continue;\
-			}\
-		}\
-		next = ptr->PTRS.next_sorted;\
-		if(next && KEYCMP(next->KEY, pos)) {\
-			ptr = next;\
-			continue;\
-		}\
-		return ptr;\
-	}\
-	return NULL;\
-}
-
-/* LINKAGE - empty or "static", depending on whether you want the definitions to
- *	be public or not
- * NAME - a string to stick in names to make this hash table type distinct from
- * 	any others
- * HASHSIZE - number of buckets
- * TYPE - type of data contained in the buckets - must be a structure, one 
- * 	field is of type NAME_ptrs, another is the hash key
- * PTRS - TYPE must contain a field of type NAME_ptrs, PTRS is the name of that
- * 	field
- * KEYTYPE - type of the key field within TYPE
- * KEY - name of the key field within TYPE
- * KEYCMP - pointer to function that compares KEYTYPEs to each other - the
- * 	prototype is int KEYCMP(KEYTYPE, KEYTYPE), it returns zero for equal, 
- * 	non-zero for not equal
- * HASHFN - the hash function - the prototype is int HASHFN(KEYTYPE),
- * 	it returns a number in the range 0 ... HASHSIZE - 1
- * Call DEF_HASH_STRUCTS, define your hash table as a NAME_table, then call
- * DEF_HASH.
- */
-
-#define DEF_HASH_STRUCTS(NAME,HASHSIZE,TYPE) \
-\
-struct NAME##_table {\
-	TYPE * hashtable[HASHSIZE];\
-	int nr_entries;\
-};\
-\
-struct NAME##_ptrs {\
-	TYPE * next_hash;\
-	TYPE * prev_hash;\
-};
-
-#define DEF_HASH(LINKAGE,NAME,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,HASHFN)\
-\
-LINKAGE void insert_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	int ix = HASHFN(elem->KEY);\
-	TYPE ** base = &tbl->hashtable[ix];\
-	TYPE * ptr = *base;\
-	TYPE * prev = NULL;\
-\
-	tbl->nr_entries++;\
-	while(ptr && KEYCMP(ptr->KEY, elem->KEY)) {\
-		base = &ptr->PTRS.next_hash;\
-		prev = ptr;\
-		ptr = *base;\
-	}\
-	elem->PTRS.next_hash = ptr;\
-	elem->PTRS.prev_hash = prev;\
-	if(ptr) {\
-		ptr->PTRS.prev_hash = elem;\
-	}\
-	*base = elem;\
-}\
-\
-LINKAGE void remove_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
-{\
-	TYPE * next = elem->PTRS.next_hash;\
-	TYPE * prev = elem->PTRS.prev_hash;\
-\
-	tbl->nr_entries--;\
-	if(next)\
-		next->PTRS.prev_hash = prev;\
-	if(prev)\
-		prev->PTRS.next_hash = next;\
-	else {\
-		int ix = HASHFN(elem->KEY);\
-		tbl->hashtable[ix] = next;\
-	}\
-}\
-\
-LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
-{\
-	int ix = HASHFN(pos);\
-	TYPE * ptr = tbl->hashtable[ix];\
-	while(ptr && KEYCMP(ptr->KEY, pos))\
-		ptr = ptr->PTRS.next_hash;\
-	return ptr;\
-}
-
-#endif
diff -puN arch/um/kernel/physmem.c~uml-fold-ghash-h-inside-physmem-c arch/um/kernel/physmem.c
--- uml-linux-2.6.8.1/arch/um/kernel/physmem.c~uml-fold-ghash-h-inside-physmem-c	2004-09-09 18:56:28.381109520 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/physmem.c	2004-09-09 19:43:52.463743240 +0200
@@ -4,7 +4,6 @@
  */
 
 #include "linux/mm.h"
-#include "linux/ghash.h"
 #include "linux/slab.h"
 #include "linux/vmalloc.h"
 #include "linux/bootmem.h"
@@ -45,6 +44,85 @@ static struct add_mapping(void *addr, st
 #define PHYS_HASHSIZE (8192)
 
 struct phys_desc;
+/* LINKAGE - empty or "static", depending on whether you want the definitions to
+ *	be public or not
+ * NAME - a string to stick in names to make this hash table type distinct from
+ * 	any others
+ * HASHSIZE - number of buckets
+ * TYPE - type of data contained in the buckets - must be a structure, one
+ * 	field is of type NAME_ptrs, another is the hash key
+ * PTRS - TYPE must contain a field of type NAME_ptrs, PTRS is the name of that
+ * 	field
+ * KEYTYPE - type of the key field within TYPE
+ * KEY - name of the key field within TYPE
+ * KEYCMP - pointer to function that compares KEYTYPEs to each other - the
+ * 	prototype is int KEYCMP(KEYTYPE, KEYTYPE), it returns zero for equal,
+ * 	non-zero for not equal
+ * HASHFN - the hash function - the prototype is int HASHFN(KEYTYPE),
+ * 	it returns a number in the range 0 ... HASHSIZE - 1
+ * Call DEF_HASH_STRUCTS, define your hash table as a NAME_table, then call
+ * DEF_HASH.
+ */
+
+#define DEF_HASH_STRUCTS(NAME,HASHSIZE,TYPE) \
+\
+struct NAME##_table {\
+	TYPE * hashtable[HASHSIZE];\
+	int nr_entries;\
+};\
+\
+struct NAME##_ptrs {\
+	TYPE * next_hash;\
+	TYPE * prev_hash;\
+};
+
+#define DEF_HASH(LINKAGE,NAME,TYPE,PTRS,KEYTYPE,KEY,KEYCMP,HASHFN)\
+\
+LINKAGE void insert_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
+{\
+	int ix = HASHFN(elem->KEY);\
+	TYPE ** base = &tbl->hashtable[ix];\
+	TYPE * ptr = *base;\
+	TYPE * prev = NULL;\
+\
+	tbl->nr_entries++;\
+	while(ptr && KEYCMP(ptr->KEY, elem->KEY)) {\
+		base = &ptr->PTRS.next_hash;\
+		prev = ptr;\
+		ptr = *base;\
+	}\
+	elem->PTRS.next_hash = ptr;\
+	elem->PTRS.prev_hash = prev;\
+	if(ptr) {\
+		ptr->PTRS.prev_hash = elem;\
+	}\
+	*base = elem;\
+}\
+\
+LINKAGE void remove_##NAME##_hash(struct NAME##_table * tbl, TYPE * elem)\
+{\
+	TYPE * next = elem->PTRS.next_hash;\
+	TYPE * prev = elem->PTRS.prev_hash;\
+\
+	tbl->nr_entries--;\
+	if(next)\
+		next->PTRS.prev_hash = prev;\
+	if(prev)\
+		prev->PTRS.next_hash = next;\
+	else {\
+		int ix = HASHFN(elem->KEY);\
+		tbl->hashtable[ix] = next;\
+	}\
+}\
+\
+LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
+{\
+	int ix = HASHFN(pos);\
+	TYPE * ptr = tbl->hashtable[ix];\
+	while(ptr && KEYCMP(ptr->KEY, pos))\
+		ptr = ptr->PTRS.next_hash;\
+	return ptr;\
+}
 
 DEF_HASH_STRUCTS(virtmem, PHYS_HASHSIZE, struct phys_desc);
 
_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
